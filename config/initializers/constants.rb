CURR_DAYS = {1 => "M", 2 => "T", 3 => "W", 4 => "Th", 5 => "F", 6 => "Sa", 0 => "Su"}
DAYS = {0 => "SU", 1 => "MO", 2 => "TU", 3 => "WE", 4 => "TH", 5=> "FR", 6 => "SA" }
FULL_DAYS = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5=> "Friday", 6 => "Sa" }

CLASSES_START = Date.new(2009, 02, 25)
CLASSES_END = Date.new(2009, 06, 01)

SUBJECT_TAGS = YAML::load(File.read("config/tags.yaml"))

class Array
  def to_h(keys)
    Hash[*keys.zip(self).flatten]
  end
end

def random_rgb()
  rgb = ["2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E"]
  
  color = ""
  
  srand()
  (6).times do
    color += rgb[(rand() * rgb.length).to_i].to_s
  end
  
  return color
end