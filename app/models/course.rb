class Course < ActiveRecord::Base
  include CourseParser
  has_and_belongs_to_many :users
  has_and_belongs_to_many :time_periods
  
  before_save :parse
  
  validates :code, :presence   => true,
  :uniqueness => true,
  :format     => { :with => /[A-Z]+[0-9]+.[0-9]+/, :message => "must be in the format AA[A].1234.01" }
  
  validates :title, :presence   => true,
  :uniqueness => true,
  :length     => { :within => 3..250 }

  validates :instructor, :presence   => true
  validates :description, :presence => true
  validates :time, :presence => true
  validates :credits, :format => { :with => /[0-9]/, :message => "must be an integer"}
  
  def to_s
    self.code + ": " + self.title
  end
end
