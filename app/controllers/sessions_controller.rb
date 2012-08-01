# encoding: utf-8
class SessionsController < ApplicationController
  #  ssl_required :home,:new,:create,:logout if SSL_ENABLE
    before_filter :user_authorize
   skip_before_filter :user_authorize, :only => [:new, :create]
  layout "login"
  #     ssl_required :create,:new,:home if RAILS_ENV == "production"
  # Just render the welcome screen and a main navigator to administrator logged
  # in.
  def home
    @user = User.find_by_name(session[:user_name])
#    @title = "SHARP后前管理系统"
    # render :layout => "application"
    render :layout => "users"
  end

   def yinsi
#    @title = "SHARP后前管理系统"
    render :layout => "users"
  end


  def logout
    session[:user_name] = nil
    redirect_to :action => "new"
  end

  def new

  end

  def create
    user = User.find_by_name_and_password(params[:name], params[:password])
    if user
      session[:user_name] = user.name
      redirect_to :action => :home
      flash[:notice] = "Logged in successfully"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new', :layout => "admin/login"
    end
  end

  def destroy

    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end


  def setlocale
    #    redirect_to (request.env['HTTP_REFERER'] or root_path)
    render :update do |page|
      page.reload
    end
  end

  protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "请输入正确的用户名与密码!"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end

