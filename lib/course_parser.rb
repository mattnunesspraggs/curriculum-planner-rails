require 'icalendar'
require 'date'
require 'csv'

module CourseParser
  TIME_REGEX = /(?:([\d]+)(?::(\d+))?)(am|pm|noon)?/
  PERIOD_REGEX = /([0-9]+)?[\s]*#{TIME_REGEX}[\s]*-[\s]*#{TIME_REGEX}/i
  
  def parse_csv(file)
    courses = []
    
    CSV::foreach(file.path) do |r|
      courses << r
    end
    
    records = courses.delete_at(0)
    courses.map!{|x| x.to_h(records)}

    return courses, records
  end
  
  def parse_subject
    c_match = self.code.match(/([A-Z]+)[0-9]+.[0-9]+/)
    if c_match
      self.subject = c_match[1]
    end
  end
  
  def parse
    if self.time.nil?
      self.time = "TBA"
    else
      parse_time
      parse_ical
    end
    
    parse_subject
    
    true
  end
  
  def parse_ical
    ical_str = []
    
    s = self.start_date ? Date.parse(self.start_date) : CLASSES_START
    e = self.end_date ? Date.parse(self.end_date) : CLASSES_END
    
    self.time_periods.each do |t|
      ev = Icalendar::Event.new
      
      ev.dtstart = DateTime.new( s.year, s.month, s.day, t.t_start_h, t.t_start_m )
      ev.duration = t.length("ical")
      ev.recurrence_rules = ["FREQ=WEEKLY;BYDAY=" + t.days(true).join(",") + ";UNTIL=" + e.strftime( "%Y%m%dT235959" )]
      ev.summary = self.code + ": " + self.title + " with " + self.instructor
      ev.description = self.description + " " + self.credits.to_s + " credits."
      
      ical_str << ev.to_ical
    end
    
    self.time_parsed = ical_str.join
  end
  
  def parse_time
    days_hash = CURR_DAYS

    days_hash = days_hash.sort{|a, b| b[1].length <=> a[1].length }
    #interesting bit of magic; sort by length of day string
    # will make search-and-replace day values more specific; i.e. will match Th before T

    unparsed_time = self.time
    days_hash.each do |k, v|
      unparsed_time = unparsed_time.gsub(v, k.to_s)
    end
    
    time_periods = []
    
    past_dayset = ""
    times = unparsed_time.split(/,[\s]*/)
    times.each do |period|
      t = TimePeriod.where("`time` = ?", period)
      
      if t.empty?
        p_match = period.match(PERIOD_REGEX)

        if p_match
          days = p_match[1] ? p_match[1].split(//) : past_dayset

          pm_e = p_match[5] != '12' && p_match[7] == 'pm'
          pm_s = (p_match[4] ? p_match[4] == 'pm' : (p_match[7] == 'noon' ? false : pm_e)) 

          t = TimePeriod.new()
          t.time = period
          t.days = p_match[1]
          t.t_start_h = pm_s && p_match[2] != '12' ? p_match[2].to_i + 12 : p_match[2].to_i
          t.t_start_m = p_match[3].to_i
          t.t_end_h = pm_e ? p_match[5].to_i + 12 : p_match[5].to_i
          t.t_end_m = p_match[6].to_i
          t.save

          past_dayset = days
        end
      end
      
      self.time_periods << t
    end
  end
end
