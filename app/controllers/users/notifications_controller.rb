class Users::NotificationsController < ApplicationController

  def index
    @notifications = current_user.apponent_notifications.page(params[:page]).per(10)
    # [ページネーション] kaminariの存在
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # 未確認の通知レコードだけ開いた後、確認済みに変換されるよう
  end

end