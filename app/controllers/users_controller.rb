class UsersController < ApplicationController
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_to('/profile', :notice => "Thanks for signing up! You can now begin using your account.")
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def edit
    if is_group?("admin")
      @user = User.find_by_id(params[:id])
    else
      @user = current_user
    end
    
    render 'edit'
  end
  
  def update
    @user = User.find_by_id(params[:id])
    me  = @user == current_user
    
    params[:user].each do |param, value|
      @user.update_attribute(param, value)
    end
    
    success = @user && @user.save
    if success && @user.errors.empty?
      flash[:notice] = "#{@user} updated successfully!"
      if me
        redirect_to home_path
      elsif !me and is_group?("admin")
        redirect_to @user
      end
    else
      flash[:error] = "#{@user} could not be updated."
      render 'edit'
    end
  end
  
  def profile
    @user = current_user
    render 'my_profile'
  end

  def show
    if @user = User.find_by_id(params[:id]) && @user && !@user.private?
      flash[:notice] = "You are now viewing " + @user.to_s + "'s profile."
    else
      @user = current_user
      flash[:error] = "That user does not exist, or cannot be viewed.  So... here.  Amuse yourself with your own profile." 
    end
    
    @title = @user.to_s + "'s Profile"
    
    render 'public_profile'
  end

end
