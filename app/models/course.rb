class Course < ActiveRecord::Base
  include CourseParser
  has_and_belongs_to_many :users
  has_and_belongs_to_many :time_periods
  
  before_save :parse
  
  validates :code, :presence   => true,
  :uniqueness => true,
  :format     => { :with => /[A-Z]+[0-9]+[L]?.[0-9]+/, :message => "must be in the format AA[A].####.##" }
  
  validates :title, :presence   => true,
  :length     => { :within => 3..250 }

  validates :instructor, :presence => true
  validates :credits, :format => { :with => /[0-9]/, :message => "must be an integer"}
  
  def to_s
    self.code + ": " + self.title
  end
  
  def time_commitment(format = "")
    len = 0
    self.time_periods.each do |tp|
      len += tp.length("decimal")
    end
    
    if format.downcase == "decimal"
      return len.round(2)
    else
      m = len % 1
      h = len - m
      return "#{h.to_i} h #{(m*60).round} min"
    end
  end
end
