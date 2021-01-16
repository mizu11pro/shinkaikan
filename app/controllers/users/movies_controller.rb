class Users::MoviesController < ApplicationController

  def search
    @movie_search = Movie.search(params[:search])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
    redirect_to movies_path
  end

  def index
    @reports = Report.all.order(id: "DESC")
    @average_movie_comment = MovieComment.average(:evaluation)
    @genres = Genre.where(is_genre: true)
      # if params[:genre_id].present?
      #   @genre = Genre.find(params[:genre_id])
      #   @genre_movie = Genre.movie.where(is_movie: true)
      # end
      if current_user.is_admin
        @movies = Movie.all.order(id: "DESC")
      else
        @movies = Movie.where(is_movie: true ).order(id: "DESC")
      end
  end

  def genre_movie
    @movie = Movie.find(params[:movie_id])
  end

    # @items = Item.where(is_active: false).page(params[:page]).per(8)
    # # 全商品一覧商品数表示用
    # @items_for_index = Item.where(is_active: false)
    # @genres = Genre.where(is_active: true)

    # if params[:genre_id].present?
    #   @genre = Genre.find(params[:genre_id])
    #   # ジャンル別商品一覧のページネーション用
    #   @genres_for_index = @genre.items.where(is_active: false).page(params[:page]).per(8)
    # end

  def show
    @movie = Movie.find(params[:id])
    @movie_comment = MovieComment.new
    @movie_comments = MovieComment.all.order(id: "DESC")
    @average_movie_comment = MovieComment.average(:evaluation)
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    redirect_to movies_path
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
