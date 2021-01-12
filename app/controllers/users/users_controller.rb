class Users::UsersController < ApplicationController

  def index
    @user = current_user
    if current_user || is_admin
      @users = User.where(is_admin: false)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :is_admin)
  end
end