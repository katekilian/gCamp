class UsersController < ApplicationController

  before_action :only_change_own_user_profile, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: "User was successfully created"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user.id == user.id
      User.destroy(params[:id])
      session.clear
      redirect_to root_path
    else
      User.destroy(params[:id])
      redirect_to users_path 
    end
  end

  private

  def user_params
    if current_user.is_admin?
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end

  def only_change_own_user_profile
    @user = User.find(params[:id])
    unless current_user.id == @user.id || current_user.is_admin?
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

end
