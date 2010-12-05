require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  has_and_belongs_to_many :courses

  set_table_name 'users'

  validates :login, :presence   => true,
                    :uniqueness => true,
                    :length     => { :within => 3..40 },
                    :format     => { :with => Authentication.login_regex, :message => Authentication.bad_login_message }

  validates :email, :presence   => true,
                    :uniqueness => true,
                    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message },
                    :length     => { :within => 6..100 }

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def status(string)
    self.status.include?(string)
  end
  
  def name
    if !self.first_name or !self.last_name
      return self.login
    else
      return (self.preferred_name || self.first_name) + " " + self.last_name
    end
  end
  
  def short_name
    (self.preferred_name || self.first_name) || self.login
  end
  
  def to_s
    self.name
  end
  
  def private?
    self.private
  end
  
  def enrolled_in(course)
    self.courses.include?(course)
  end
  
  def enroll(course)
    self.courses << course if !enrolled_in(course)
    self.save
  end
  
  def drop_course(course)
    self.courses.delete(course)
    self.save
  end
  
  def credits()
    credits = 0
    self.courses.each do |c|
      credits += c.credits.to_i
    end
    
    credits
  end
  
  protected
  


end
