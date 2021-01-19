class Movie < ApplicationRecord

  attachment :image

  validates :is_movie, inclusion: { in: [true, false] }

  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :genre

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
    return Movie.all unless search
      Movie.where(['title LIKE ?', "%#{search}%"])
      # Movie.where(['directed_by LIKE ?', "%#{search}%"])
  end
end
