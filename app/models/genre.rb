class Genre < ApplicationRecord

  validates :is_genre, inclusion: { in: [true, false] }

  has_many :movies
end
