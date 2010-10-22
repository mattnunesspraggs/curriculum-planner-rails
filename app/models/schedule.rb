class Schedule < ActiveRecord::Base
    belongs_to :user
    has_and_belongs_to_many :courses
    
    def include?(x)
      courses.include?(x)
    end
end
