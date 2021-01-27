class Users::GenresController < ApplicationController
  before_action :authenticate_user!

  def index
    @genre = Genre.new
    @genres = Genre.all
    if current_user.is_admin == true
      render "index"
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    @genre.save
  end

  def edit
    @genre = Genre.find(params[:id])
    if current_user.is_admin == true
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render "edit"
    end
  end

  def destroy
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre.destroy
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_genre)
  end
end
