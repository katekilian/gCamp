class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :require_login

  def current_user
    User.find_by(id: session[:user_id])
  end

 private

 def require_login
   unless current_user
     flash[:error] = "You must sign in"
     redirect_to sign_in_path # halts request cycle
   end
 end

end
