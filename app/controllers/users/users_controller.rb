class Users::UsersController < ApplicationController
  before_action :authenticate_user!

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
    @reports = Report.all.order(created_at: "DESC").limit(3)
    @user = User.find(params[:id])
    @favorites = @user.favorites.where(movie_id: params[:movie_id])
    @rank_movies = Movie.joins(:movie_comments).where(movie_comments: { user_id: params[:id]}).order(evaluation: :desc).limit(3)
    # movieがmovie＿commentだけを持っているmovieを取得
    # それに対してmovie_commentのuser_idの条件を指定

  # @rank_movies = []
  #  @rank_movies_tmp.each.with_index(1) do |movie, i|
	#   @movie_comments.each.with_index(1) do |movie_comment, j|
  # 		  if movie.id == movie_comment.movie_id
  # 		    @rank_movies << movie
  # 		  end
	#   end
	# end
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
        redirect_to user_path(@user)
      end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :email ,:profile_image, :is_admin, :message_id)
  end
end