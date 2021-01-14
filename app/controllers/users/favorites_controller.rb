class Users::FavoritesController < ApplicationController

  def index
    movie_ids = Favorite.where(user_id: params[:user_id]).pluck(:movie_id)
    @movies = Movie.where(id: movie_ids)
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.new(movie_id: @movie.id)
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    # @favorite = Favorite.find_by(movie_id: movie_id, user_id: current_user).destroy
    # コード省略記述が上手くいかない
    @movie = Movie.find(params[:movie_id])
    @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    @favorite.destroy
    redirect_to request.referer
  end

end