class MovieComment < ApplicationRecord

  belongs_to :user
  belongs_to :movie

  validates :evaluation, presence: true
end
