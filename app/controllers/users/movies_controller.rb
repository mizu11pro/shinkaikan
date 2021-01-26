class Users::MoviesController < ApplicationController
  before_action :authenticate_user!

  def search
    @movie_search = Movie.search(params[:search])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      render "new"
    end
  end

  def index
    @reports = Report.all.order(created_at: "DESC").limit(3)
    @rank_movie = Movie.all.sort_by { |movie| movie.movie_comments.average(:evaluation).to_i }.reverse.take(3)
    @genres = Genre.where(is_genre: true)
      if params[:genre_id].present?
        @genre = Genre.find(params[:genre_id])
        @genre_movies = @genre.movies.where(is_movie: true )
      end
      if current_user.is_admin
        @movies = Movie.all.order(id: "DESC")
      else
        @movies = Movie.where(is_movie: true ).order(id: "DESC")
      end
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
    # 結果が1件しかないのでfind_byを使う
    @user_comment = @movie.movie_comments.find_by(user_id: current_user)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render "edit"
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :directed_by, :body, :image, :is_movie, :genre_id)
  end

end
