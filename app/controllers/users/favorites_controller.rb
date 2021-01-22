class Users::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @reports = Report.all.order(created_at: "DESC").limit(3)
    @movie_ids = Favorite.where(user_id: params[:user_id]).pluck(:movie_id)
    @movies = Movie.where(id: @movie_ids)
    @movie = Movie.where(id: @movie_ids)
    @favorites = Movie.joins(:favorites).where(favorites: { user_id: params[:id]})
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.new(movie_id: @movie.id)
    @favorite.save
  end

  def destroy
    # @favorite = Favorite.find_by(movie_id: movie_id, user_id: current_user).destroy
    # コード省略記述が上手くいかない
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    @favorite.destroy
  end

end