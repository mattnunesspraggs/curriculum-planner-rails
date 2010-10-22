class Course < ActiveRecord::Base
  include ClassList
  has_and_belongs_to_many :schedules
end
