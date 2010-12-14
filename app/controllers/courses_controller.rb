class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.xml
  before_filter :admin_required, :except => [:index, :search, :remote_search, :setup]
  #include CourseParser
  
  protected
  
  def setup
    if current_user
      @enrolled_courses = current_user.courses.to_a
    else
      @enrolled_courses = false
    end
  end
  
  public
  
  def upload
    
  end
  
  def upload_remote
    
    if params[:delete_all]
      Course.all.each do |course|
        c.destroy
      end
    end
    
    if params[:file]
      courses, records = parse_tsf( params[:file] )
      
      # CompositeCourseNumber, DefaultCreditHours, Title, CourseDescription, InstructorFirstNameLastName, Period
      map = { :code => "CompositeCourseNumber", :credits => "DefaultCreditHours", :description => "CourseDescription", :title => "Title", :instructor => "InstructorFirstNameLastName", :time => "Period"}
      
      errors = []
      
      courses.each do |course|
        c = Course.new
        map.each do |model_attr, field|
          c[model_attr] = course[field]
        end
        
        if !c.valid? then errors << [course, c.errors] end
      end
      
      if errors.empty?
        flash[:notice] = courses.count #.to_s + " uploaded successfully."
      else
        flash[:error] = errors.count.to_s + " errors"
        Rails.logger.error(errors.inspect)
      end
    else
      flash[:error] = "File upload failed."
    end
    
    redirect_to "/courses/upload"
  end
  
  def remote_search
    @q = params["q"]
    @courses = Course.where("code LIKE :q OR title LIKE :q OR instructor LIKE :q OR description LIKE :q or time LIKE :q", :q => ("%" + params["q"] + "%"))
    
    respond_to do |format|
      format.js {
      }
    end
  end
  
  def search
  end
  
  def index
    setup()
    @courses = Course.order("code ASC").all
    @title = "Course listing"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    setup()
    @course = Course.find(params[:id])
    @title = @course.to_s

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:message] = "Course {@course.to_s} was destroyed."

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
end
