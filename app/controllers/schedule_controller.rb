class ScheduleController < ApplicationController
  before_filter :login_required
  
  def index
    @title = "Schedule viewer"
    @courses = current_user.courses
    
    unscheduled = []
    @courses.each do |c|
      if c.time == "TBA"
        unscheduled << "\"" + c.title + "\""
      end
    end
    
    if unscheduled.count > 0
      flash[:notice] = "Not seeing all your courses? " + unscheduled.to_sentence + (unscheduled.count == 1 ? " is" : " are" ) + " not yet scheduled, so we won't bother to put them up here."
    end
    
    respond_to do |format|
      format.html
      format.ics
    end
  end
  
  def add
    @user = current_user
    @course = Course.find_by_id(params[:course])
    
    if @user.enroll(@course)
      flash[:message] = "The course \"#{@course.title}\" was added to your schedule."
      respond_to do |format|
        format.js { render 'courses/course_added.js.erb' }
      end
    else
      respond_to do |format|
        format.js {
          flash[:error] = "The course #{@course.title} could not be added."
          render "application/update_flash.js.erb"
        }
      end
    end
  end
  
  def remove
    @user = current_user
    @course = Course.find_by_id(params[:course])

    if @user.drop_course( @course )
      respond_to do |format|
        format.js { 
          flash[:message] = "The course \"#{@course.title}\" was removed from your schedule."
          render 'courses/course_removed.js.erb'
        }
      end
    else
      respond_to do |format|
        format.js {
          flash[:error] = "The course #{@course.title} could not be added."
          render "application/update_flash.js.erb"
        }
      end
    end
  end
end