class Users::MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def index
    @movie = Movie.new
    @reports = Report.all.order(id: "DESC")
    @movies = Movie.all.order(id: "DESC")
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.save
    redirect_to movie_path
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movie_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :body, :image)
  end

end
