class Favorite < ApplicationRecord

  # has_many :notifications, dependent: true
  belongs_to :user
  belongs_to :movie
end
