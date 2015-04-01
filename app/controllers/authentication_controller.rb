class AuthenticationController < PublicController

  def new
    # @user = User.find(params[:id])
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in"
      redirect_to session[:previous_url] || projects_path
    else
      @sign_in_error = "Email / Password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have successfully signed out"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
