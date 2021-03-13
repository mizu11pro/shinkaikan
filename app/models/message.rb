class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, presence: true

  def save_notification_message!(current_user, message, visited_id)
    notifiation = current_user.active_notifications.new(
      # favorite_id: id,
      message: id,
      visitor_id: id,
      action: ' message'
      )

      if notifiation.visitor_id == notification.visitor_id
        notification.checked = true
      end
      # 自身のmessageに対する通知は、通知済みとすることで自身には送られないようにする
      notification.save if notification.valid?
  end

end
