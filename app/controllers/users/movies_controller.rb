class Users::MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to root_path
  end

  def index
    @reports = Report.all.order(id: "DESC")
    if current_user.is_admin
      @movies = Movie.all.order(id: "DESC")
    else
      @movies = Movie.where(is_movie: true ).order(id: "DESC")
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to root_path
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to root_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :body, :image, :is_movie)
  end

end
