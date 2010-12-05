class Course < ActiveRecord::Base
  include TimeParser
  has_and_belongs_to_many :users
  has_and_belongs_to_many :time_periods
  
  before_save :parse_time
  
  def to_s
    self.code + ": " + self.title
  end
end
