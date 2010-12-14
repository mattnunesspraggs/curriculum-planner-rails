module ApplicationHelper
  mattr_accessor :profile_path
  
  def delete_status_path(user)
    "/users/#{user.id}/delete"
  end
  
  def signup_path
    "/signup"
  end
  
  def about_path
    "/about"
  end
  
  def login_path
    "/login"
  end
  
  def logout_path
    "/logout"
  end
  
  def profile_path
    "/home"
  end
  
  def schedule_path
    "/schedule"
  end
end
