class Genre < ApplicationRecord

  validates :is_genre, inclusion: { in: [true, false] }
end
