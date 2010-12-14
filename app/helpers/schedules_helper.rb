module SchedulesHelper
  
  def draw_course(course)
    
  end
  
  def draw_class_block(course)
    color, bg_color = random_rgb
		
		height = (course.time_commitment("decimal") / user_time_commitment) * 387
		class_block = link_to((course.title + "<br />" + course.credits.to_s + 
		" credits").html_safe, course,
		:class => "time-block class-block course_#{course.id}", :id => "course_#{course.id}",
		:style => "height: #{class_block_height}px; background-color: ##{bg_color}; color: ##{color}")
  end
  
end