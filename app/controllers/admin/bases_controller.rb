class Admin::BasesController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
#  include ExceptionNotifiable
  layout "admin/base"
  before_filter :admin_authorize ,:set_locale
  before_filter do
    begin
      @model = self.class.to_s.split('::').last.sub(/Controller$/, '').singularize.classify.constantize
      @model_string = self.class.to_s.split('::').last.sub(/Controller$/, '').singularize.downcase
    rescue
      p  'ERROR_BASE'
    end
  end


  #
  #    protected
  #
  #  ssl_required :admin_authorize if SSL_ENABLE

  def set_locale
    session[:locale] = params[:locale] if params[:locale]
    session[:locale] = "zh" if session[:locale].blank?
    I18n.locale = session[:locale] || I18n.default_locale
  end
  def admin_authorize
    if session[:admin]
      return true
    else
      redirect_to new_admin_session_path
      return false
    end
  end

  def admin_user
    if session[:is_admin]
      return true
    else
#      flash[:notice] = '阅览权限不'
      redirect_to home_admin_sessions_path
      return false
    end
  end

  def split_keyword(keyword)
    unless keyword.blank?
#            keyword.gsub!(/[　\s\t]+/o, '%')
#      keyword.gsub!(/[　\s\t]+$/o, "")
#      keyword.gsub!(/^[　\s\t]+/o, "")
#      keyword.gsub!(/[　\s\t]+/o, " ")
#      keyword.split(/(\s)/)
    end
  end
end

