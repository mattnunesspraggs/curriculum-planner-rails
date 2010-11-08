require 'icalendar'
require 'date'

class Course < ActiveRecord::Base
  include Icalendar
  has_and_belongs_to_many :users
  
  before_save :parse_time
  
    def to_event

      days_hash = CURR_DAYS
      time_regex = /(?:([\d]+)(?::(\d+))?)(am|pm|noon)?/
      period_regex = /([0-9]+)?[\s]*#{time_regex}[\s]*-[\s]*#{time_regex}/i

      days_hash = days_hash.sort{|a, b| b[1].length <=> a[1].length }
      #interesting bit of magic; sort by length of day string
      # will make search-and-replace day values more specific; i.e. will match Th before T

      unparsed_time = self.time
      days_hash.each do |k, v|
        # replace day strings with numbers; make it easier to represent
        # internally - more universal
        unparsed_time = unparsed_time.gsub(v, k.to_s)
      end

      times = unparsed_time.split(/,[\s]+/)
      past_dayset = "" # for example, TF 10:10-12noon, 2:10-4pm
      block = [] # final product
      str_until = CLASSES_END.strftime("%Y%m%dT235959Z")
      class_start_day = CLASSES_START.wday

      times.each do |period|
        p_match = period.match(period_regex)

        if p_match
          days = p_match[1] ? p_match[1].split(//) : past_dayset

          offset = nil
          days.each_with_index do |d, i|
            days[i] = d.to_i
            if days[i] >= class_start_day then offset = days[i] end
          end

          if !offset then
            offset = days[0] + 7
          end
          class_start = CLASSES_START + offset

          pm_s = (p_match[4] || (p_match[7] == 'noon' ? 'am' : p_match[7])) == 'pm'
          pm_e = p_match[7] == 'pm'

          e = Event.new
          # clean this up a little?
          e.start = DateTime.civil(
            class_start.year,
            class_start.month,
            class_start.day,
            pm_s ? p_match[2].to_i + 12 : p_match[2].to_i, #hour
            p_match[3].to_i #minute
          )
          e.end = DateTime.civil(
            class_start.year,
            class_start.month,
            class_start.day,
            pm_e ? p_match[5].to_i + 12 : p_match[5].to_i, #hour
            p_match[6].to_i #minute
          )

          e.description = self.code + ": " + self.title + " with " + self.instructor
          e.summary = self.title

          r_days = []
          days.each do |d|
            r_days << DAYS[d]
          end

          e.recurrence_rules = ["FREQ=WEEKLY;INTERVAL=1;UNTIL=#{str_until};BYDAY=#{r_days.join(',')};WKST=SU"]
          klass = "BUSY"

          block << e
          past_dayset = days
        else
          raise "ParseTime::MatchError"
        end
      end

      return block
    end
  
  def parse_time
    
    days_hash = CURR_DAYS
    time_regex = /(?:([\d]+)(?::(\d+))?)(am|pm|noon)?/
    period_regex = /([0-9]+)?[\s]*#{time_regex}[\s]*-[\s]*#{time_regex}/i

    days_hash = days_hash.sort{|a, b| b[1].length <=> a[1].length }
    #interesting bit of magic; sort by length of day string
    # will make search-and-replace day values more specific; i.e. will match Th before T

    unparsed_time = self.time
    days_hash.each do |k, v|
      # replace day strings with numbers; make it easier to represent
      # internally - more universal
      unparsed_time = unparsed_time.gsub(v, k.to_s)
    end

    times = unparsed_time.split(/,[\s]+/)
    past_dayset = "" # for example, TF 10:10-12noon, 2:10-4pm
    block = "" # final product
    str_until = CLASSES_END.strftime("%Y%m%dT235959Z")
    class_start_day = CLASSES_START.wday
    
    times.each do |period|
      p_match = period.match(period_regex)
      
      if p_match
        days = p_match[1] ? p_match[1].split(//) : past_dayset
        
        offset = nil
        days.each_with_index do |d, i|
          days[i] = d.to_i
          if days[i] >= class_start_day then offset = days[i] end
        end
        
        if !offset then
          offset = days[0] + 7
        end
        class_start = CLASSES_START + offset
        
        pm_s = (p_match[4] || (p_match[7] == 'noon' ? 'am' : p_match[7])) == 'pm'
        pm_e = p_match[7] == 'pm'
        
        e = Event.new
        # clean this up a little?
        e.start = DateTime.civil(
          class_start.year,
          class_start.month,
          class_start.day,
          pm_s ? p_match[2].to_i + 12 : p_match[2].to_i, #hour
          p_match[3].to_i #minute
        )
        e.end = DateTime.civil(
          class_start.year,
          class_start.month,
          class_start.day,
          pm_e ? p_match[5].to_i + 12 : p_match[5].to_i, #hour
          p_match[6].to_i #minute
        )
        
        e.description = self.code + ": " + self.title + " with " + self.instructor
        e.summary = self.title
        
        r_days = []
        days.each do |d|
          r_days << DAYS[d]
        end
        
        e.recurrence_rules = ["FREQ=WEEKLY;INTERVAL=1;UNTIL=#{str_until};BYDAY=#{r_days.join(',')};WKST=SU"]
        klass = "BUSY"
        
        block += e.to_ical
        past_dayset = days
      else
        return self.time_parsed = "ERROR"
      end
    end

    return self.time_parsed = block
  end
end
