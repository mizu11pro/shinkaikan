class Movie < ApplicationRecord
  attachment :image

  with_options presence: true do
    validates :title
    validates :body
    validates :directed_by
    validates :image
    validates :genre_id
  end
  validates :is_movie, inclusion: { in: [true, false] }

  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: destroy

  belongs_to :genre

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Movie.all unless search
    Movie.where(['title LIKE ?', "%#{search}%"])
  end

end
