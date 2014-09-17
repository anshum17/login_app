class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json

  before_filter :check_login_status , :only => [:logout, :profile, :edit]

  

  def index
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    @login = Login.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    @login = Login.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/1/edit
  def edit
    @login = Login.find(params[:id])
  end

  # POST /logins
  # POST /logins.json
  def create

    
    @login = Login.new(params[:login])

    respond_to do |format|
      if @login.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@login).deliver
        format.html { redirect_to @login, notice: 'Login was successfully created.' }
        format.json { render json: @login, status: :created, location: @login }
      else
        format.html { render action: "new" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      
      if @login.update_attributes(params[:login])
        debugger
        format.html { redirect_to @login, notice: 'Info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  

  def validate
    validate_check = Login.validate_entry(params)
    
    if validate_check[:status]
      session[:email] = validate_check[:email]
      #redirect_to "/profile"
      #session[:password] = validate_check[:password]
      render :json => validate_check, :status => 200
    else
      render :json => validate_check
      #redirect_to "/logins", :notice => validate_check[:message]
    end
  end

  def logout
    session[:email] = nil
    flash[:message] = "You have been successfully logged out !"
    redirect_to "/logins"
  end


  def profile

    # @login = Login.find_by_email(params[:email])
    # #redirect_to :actiom => ""
    # render "/login/" + params[:email] + "/logged_in"
  end

  def send_mail
    UserMailer.forgot_password(params).deliver
    redirect_to "/logins"
  end
end


