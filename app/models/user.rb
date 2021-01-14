class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image


  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :like_movies, dependent: :destroy
# follow機能
  has_many :of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
  relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search(search)
    return User.all unless search
      User.where(['name LIKE ?', "%#{search}%"])
  end

  def self.guest
    find_or_create_by!(email: 'guest@user.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end