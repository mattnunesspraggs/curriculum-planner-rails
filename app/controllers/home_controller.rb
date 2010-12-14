class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to home_path
    end
  end
  
  def about
    @count = Course.all.count
  end
end
