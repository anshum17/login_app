class ApplicationController < ActionController::Base
  # protect_from_forgery
  def check_login_status
    if session[:email].nil?
      flash[:message] = "You are not logged in. Please log in again"
      redirect_to "/logins"
    else
    	@user = Login.where(:email => session[:email]).first
    end
  end
end
