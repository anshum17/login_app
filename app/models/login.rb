class Login < ActiveRecord::Base
  attr_accessible :email, :mobile_no, :name, :password

  validates :name,:password,:email,:mobile_no, :presence => true
  #validates :email, email_format: { message: "Please enter a valid Email" }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :email, :uniqueness => true
  validates :mobile_no, :numericality => true,
  						:length => {:mimimum => 10 , :maximum => 11}
  
  before_create do |login|
  	login.password = Digest::MD5.hexdigest(login.password)
  end

  def self.validate_entry(param)
  	email = param[:email]
  	password = Digest::MD5.hexdigest(param[:password])
  	@all_login = Login.all
  	flag1 = false
  	flag2 = false
  	
  	@all_login.each do |login|
  		if login.email == email 
  			flag1 = true
  			if login.password == password
  				flag2 = true
  			end 
  			break
  		end
  	end

  	output = Hash.new
  	if flag2
  		output[:status] = true
  		output[:message]= "Email and password matches"
  		#session[:valid] = "true"
    	output[:email] = email
    	output[:password] = password
  	
  	elsif flag1
  		output[:status] = false
  		output[:message]= "Email and password do not match.  Please try again."
  		
  	else
  		output[:status] = false
  		output[:message]= "Email does not exist. Please Sign up first"
  	end
  	output 
  end

end
