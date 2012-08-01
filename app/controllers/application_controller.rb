class ApplicationController < ActionController::Base
  protect_from_forgery


    def user_authorize
    if session[:user_name]
      return true
    else
      redirect_to new_session_path
      return false
    end
  end

end
