class Page < ActiveRecord::Base
  belongs_to :user
  
  alias :author :user
end
