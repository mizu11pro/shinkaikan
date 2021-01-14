class Movie < ApplicationRecord

  attachment :image

  validates :is_movie, inclusion: { in: [true, false] }

  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :like_movies, dependent: :destroy
  belongs_to :genre


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
