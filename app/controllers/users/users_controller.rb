class Users::UsersController < ApplicationController

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
    movie_ids = Favorite.where(user_id: params[:user_id]).pluck(:movie_id)
    @movies = Movie.where(id: movie_ids)
    @user = User.find(params[:id])
    @currentEntries = current_user.entries
    myRoomIds = []
      @currentEntries.each do | entry |
        myRoomIds << entry.room.id
      end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id != ?', @user.id)
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
    params.require(:user).permit(:name, :introduction, :profile_image, :is_admin, :message_id)
  end
end