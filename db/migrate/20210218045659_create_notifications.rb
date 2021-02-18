class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      # 通知を送るユーザ
      t.integer :visited_id, null: false
      # 通知を受け取るユーザ
      t.text :message
      # フォロー、いいね、追加項目
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      # 通知確認はデフォルトはfalse（確認していない時の対応）
      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :message
  end
end
