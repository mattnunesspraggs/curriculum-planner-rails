class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to "/profile"
    end
  end
  
  def about
    @title = "about"
    @count = Course.find(:all).count
  end

end
