module PagesHelper
  
  def time_diff_format( time_diff, smallest_resolution )
    output = []

    time_diff.each do |name, value|
      if value > 0
        output << pluralize(value, name.to_s)
      end
      
      if name == smallest_resolution then break end
    end

    return output.to_sentence
  end
  
end
