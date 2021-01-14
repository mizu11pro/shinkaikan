class Users::UsersController < ApplicationController

  def search
    @user_search = User.search(params[:search])
    p '----------------------'
    p @user_search
    p '----------------------'
    # @users = User.search(search)
  end

  def index
    @user = current_user
      if current_user || is_admin
        @users = User.where(is_admin: false)
      end
  end

  def show
    @user = User.find(params[:id])
    @rankmovie = Movie.joins(:favorites).group(:movie_id).order('count(movie_id) desc').limit(3)
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
    params.require(:user).permit(:name, :introduction, :profile_image, :is_admin)
  end
end