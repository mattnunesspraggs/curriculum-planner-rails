class TimePeriod < ActiveRecord::Base
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
  
  def to_s
    sh = self.t_start_h.to_i #start hour
    sm = self.t_start_m.to_i #start minute
    eh = self.t_end_h.to_i #end hour
    em = self.t_end_m.to_i #end minute
    
    t_start = (sh > 12 ? sh - 12 : sh).to_s + ":" + (sm < 10 ? "0" + sm.to_s : sm.to_s) + (sh > 12 ? "pm" : "am")
    t_end = (eh > 12 ? eh - 12 : eh).to_s + ":" + (em < 10 ? "0" + em.to_s : em.to_s) + (eh > 12 ? "pm" : "am")
    
    return self.days(true).join(", ") + " " + t_start + " - " + t_end
  end
end
