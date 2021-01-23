class Genre < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :is_genre, inclusion: { in: [true, false] }

  has_many :movies
end
