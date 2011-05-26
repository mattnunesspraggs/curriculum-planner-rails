CURR_DAYS = {1 => "M", 2 => "T", 3 => "W", 4 => "Th", 5 => "F", 6 => "Sa", 0 => "Su"}
DAYS = {0 => "SU", 1 => "MO", 2 => "TU", 3 => "WE", 4 => "TH", 5=> "FR", 6 => "SA" }
FULL_DAYS = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5=> "Friday", 6 => "Saturday" }

CLASSES_START = Date.new(2011, 08, 31)
CLASSES_END = Date.new(2011, 12, 08)

SUBJECT_TAGS = YAML::load(File.read("config/tags.yaml"))

# call once upon starting app
srand()

class Array
  def to_h(keys)
    Hash[*keys.zip(self).flatten]
  end
end

def random_rgb()
  colors = [ ["d2d744","2d28bb"], ["85d993", "7a266c" ], ["e2f905", "1d06fa"], ["2c3cba", "d3c345 "] ]
  colors << ["57325f", "a8cda0"] << ["223970", "ddc68f"] << ["7bcdf8", "843207"] << ["121609", "ede9f6"]
  colors << ["65acef","9a5310"] << ["940f2a", "6bf0d5"] << ["b63d21", "49c2de"] << ["f2b14f", "d4eb0"]
  
  return colors[ rand(colors.count) ]
end