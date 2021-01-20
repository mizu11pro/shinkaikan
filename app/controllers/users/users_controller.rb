class Users::UsersController < ApplicationController
  before_action :authenticate_user!

  def search
    @user_search = User.search(params[:search])
  end

  def index
    @user = current_user
      if current_user || is_admin
        @users = User.where(is_admin: false).where.not(email: 'guest@user.com')
      end
  end

  def show
    @user = User.find(params[:id])
    @favorites = @user.favorites.where(movie_id: params[:movie_id])
    @rank_movie = Movie.all.order(evaluation: :desc).limit(3)
    @currentEntries = current_user.entries
    myRoomIds = []
      @currentEntries.each do | entry |
        myRoomIds << entry.room.id
      end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?', @user.id)
  end

  def edit
    @user = User.find(params[:id])
      if @user == current_user
        render "edit"
      else
        redirect_to user_path(current_user)
      end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email ,:profile_image, :is_admin, :message_id)
  end
end