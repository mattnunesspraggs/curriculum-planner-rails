
class Option < ActiveRecord::Base
  before_save :serialize
  after_save :unserialize
  after_initialize :unserialize
  
  def serialize
    self.value = YAML::dump( @value )
  end
  
  def unserialize
    self.value = YAML::load( @value )
  end
end
