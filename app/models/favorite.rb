class Favorite < ApplicationRecord

  has_many :notifications, dependent: true
  belongs_to :user
  belongs_to :movie

  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and  visited_id = ? and favorite_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    # 「いいね」されているかの検索をする

    if temp.blank?
      notification = current_user.active_notifications.new(
        favorite_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # いいねされていない場合のみ、通知レコードを作成

      if notification.visitor_id == notification.visitor_id
        notification.checked = true
        # 自身のいいねには通知済みの対応
      end

      notification.save if notification.valid?
    end
  end
end
