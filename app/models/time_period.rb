require 'icalendar'

class TimePeriod < ActiveRecord::Base
  include Icalendar
  has_and_belongs_to_many :courses
  
  def days(parse = false)
    if parse
      self[:days].split(//).map do |day|
        DAYS[day.to_i]
      end
    else
      self[:days].split(//).map do |day|
        day.to_i
      end
    end
  end
  
  def start_time(format = "")
    sh = self.t_start_h #start hour
    sm = self.t_start_m #start minute
    
    if format.downcase == "decimal"
      return (sh.to_f + (sm.to_f / 60)).round(2)
    else
      return (sh > 12 ? sh - 12 : sh).to_s + ":" + (sm < 10 ? "0" + sm.to_s : sm.to_s) + (sh > 12 ? "pm" : "am")
    end
  end
  
  def end_time(format = "")
    sh = self.t_end_h #end hour
    sm = self.t_end_m #end minute
    
    if format.downcase == "decimal"
      return (sh.to_f + (sm.to_f / 60)).round(2)
    else
      return (sh > 12 ? sh - 12 : sh).to_s + ":" + (sm < 10 ? "0" + sm.to_s : sm.to_s) + (sh > 12 ? "pm" : "am")
    end
  end
  
  def length(format = "")
    each_meeting = self.end_time("decimal") - self.start_time("decimal")
    len = each_meeting * self.days.count
    
    m = (len % 1)
    h = ((len - m)).to_i.to_s
    m = (m * 60).to_i.to_s
    
    if format.downcase == "decimal"
      return len#.round(2)
    elsif format.downcase == "ical"
      return "PT" + h + "H" + m + "M0S"
    else
      return h + " hours " + m + " minutes"
    end
  end
  
  def to_s
    return self.days(true).join(", ") + " " + self.start_time + " - " + self.end_time
  end
end
