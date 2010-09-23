class Schedule < ActiveRecord::Base
    belongs_to :user
    serialize :courses
end
