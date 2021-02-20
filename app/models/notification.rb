class Notification < ApplicationRecord
default_scope -> { order(create_at: :desc) }
# 作成日順の通知からデータを取得

belongs_to :message, optional: true
belongs_to :movie, optional: true
# optional → nil処理の許可
belongs_to :visitor, class_name: 'User',  foreign_key: 'visitor_id', optional: true
belongs_to :visited, class_name: 'User', foreign_key: 'visited_id',  optional: true
# 中間テーブルUserを通してUserとUserのデータを取得

end