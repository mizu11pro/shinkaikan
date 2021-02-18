class Notification < ApplicationRecord
default_scope -> { order(create_at: :desc) }
# 新しい通知からデータを取得

belongs_to :message, optional: true
# nil処理の許可

end
