class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image

  with_options presence: true do
    validates :name, uniqueness: true, length: { minimum: 2, maximum: 10 }
    validates :email
  end
  validates :introduction, length: { maximum: 100 }

  has_many :movie_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # DM機能
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entry
  # /DM機能

  # 通知機能
  has_many :myself_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 自分からの通知
  has_many :apponent_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  # 相手からの通知
  # /通知機能

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
  # /follow機能

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, 'follow'])

    if temp.blank?
      notification = current_user.myself_notifications.new(
        visited_id: id,
        action: 'follow'
        )
        notification.save if notification.valid?
        # 通知レコードが作成されていない時のみレコード作成
    end
  end

  def self.search(search)
    return User.all unless search
    User.where(['name LIKE ?', "%#{search}%"]).where.not(name: 'guest', email: "admin@user")
  end

  def self.guest
    find_or_create_by!(email: 'guest@user.com', name: 'guest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end