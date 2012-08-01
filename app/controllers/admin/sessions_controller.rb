class Admin::SessionsController < Admin::BasesController
  #  ssl_required :home,:new,:create,:logout if SSL_ENABLE
  skip_before_filter :admin_authorize, :only => [:new, :create]
  layout "admin/login"
  #     ssl_required :create,:new,:home if RAILS_ENV == "production"
  # Just render the welcome screen and a main navigator to administrator logged
  # in.
  def home
#    @title = "SHARP后前管理系统"
    render :layout => "users"
  end


  def logout
    session[:admin] = nil
    session[:is_admin] = nil
    redirect_to :action => "new"
  end

  def new

  end

  def create
    admin = Administrator.authorize(params[:name], params[:password])
    if admin
      session[:admin] = admin.id
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
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end

