class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def search
    @user_search = User.search(params[:search])
  end

  def index
    @user = current_user
    if current_user || is_admin
      @users = User.where(is_admin: false).where.not(email: 'guest@user.com')
      @user != current_user
    end
  end

  def show
    # 一般ユーザならadminは見れないのでルートにリダイレクトさせる.
    return redirect_to root_path if unauthrize_showing_admin_user?

    @reports = Report.all.order(created_at: "DESC").limit(3)
    @favorites = @user.favorites.where(movie_id: params[:movie_id])
    @rank_movies = Movie.joins(:movie_comments).where(movie_comments: { user_id: params[:id] }).order(evaluation: :desc).limit(3)

    # DM履歴の相手方との最終メッセージ取得
    @current_entries = current_user.entries
    my_room_ids = []
    @current_entries.each do |entry|
      my_room_ids << entry.room.id
    end
    @anothet_entries = Entry.where(room_id: my_room_ids).where('user_id != ?', @user.id)
  end

  def edit
    if @user == current_user && guests_cannot_open
      render "edit"
    else
      redirect_to user_path(@user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image, :is_admin, :message_id)
  end

  def unauthrize_showing_admin_user?
    current_user.is_admin == false && @user.is_admin == true
  end

  def guests_cannot_open
    current_user.email != "guest@user.com"
  end

  def set_user
    @user = User.find(params[:id])
  end
end
