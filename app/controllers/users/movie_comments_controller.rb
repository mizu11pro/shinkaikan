class Users::MovieCommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @movie_comment = current_user.movie_comments.new(movie_comment_params)
    @movie_comment.movie_id = @movie.id
    @movie_comment.save
    redirect_to request.referer
  end

  def destroy
    MovieComment.find_by(movie_id: params[:movie_id], id: params[:id]).destroy
    redirect_to request.referer
  end

  private

  def movie_comment_params
    params.require(:movie_comment).permit(:comment)
  end
end