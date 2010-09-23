# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Curriculum::Application.initialize!

class String
  def prefer(another)
    if another and !another.empty?
      another
    else
      self
    end
  end
end
