class Users::NotificationsController < ApplicationController

  def index
    @notifications = @notifications.where.not(visitor_id: current_user.id)
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    # page(params[:page]).per(20) = [ページネーション] kaminariの存在
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # 未確認の通知レコードだけ開いた後、確認済みに変換されるよう
  end

end