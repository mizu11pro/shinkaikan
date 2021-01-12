class Movie < ApplicationRecord

  validates :is_movie, inclusion: { in: [true, false] }

  attachment :image
end
