class Users::MovieCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @movie_comment = current_user.movie_comments.new(movie_comment_params)
    @movie_comment.movie_id = @movie.id
    @movie_comment.save
    @user_comment = @movie.movie_comments.where(user_id: current_user.id)
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @movie_comment = @movie.movie_comments.find(params[:id])
    @movie_comment.destroy
    @user_comment = @movie.movie_comments.where(user_id: current_user.id)
  end

  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment, :evaluation)
  end
end