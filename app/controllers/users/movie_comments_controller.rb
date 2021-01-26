class Users::MovieCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:movie_id])
    @movie_comment = current_user.movie_comments.new(movie_comment_params)
    @movie_comment.movie_id = @movie.id
    unless @movie_comment.save
      render 'error'
    end
    @user_comment = @movie.movie_comments.find_by(user_id: current_user.id)
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @movie_comment = @movie.movie_comments.find(params[:id])
    @user_comment = @movie.movie_comments.where(user_id: current_user.id)
    @movie_comment.destroy
  end

  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment, :evaluation)
  end
end