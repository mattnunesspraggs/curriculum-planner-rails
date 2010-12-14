require 'icalendar'
require 'date'
require 'csv'

module CourseParser
  TIME_REGEX = /(?:([\d]+)(?::(\d+))?)(am|pm|noon)?/
  PERIOD_REGEX = /([0-9]+)?[\s]*#{TIME_REGEX}[\s]*-[\s]*#{TIME_REGEX}/i
  
  def parse_tsf(file)
    courses = []
    
    CSV::open(file.path, 'r').each do |r|
      #courses << r
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
    parse_time
    parse_subject
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
