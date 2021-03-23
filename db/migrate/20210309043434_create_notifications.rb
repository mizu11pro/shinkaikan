class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|

      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :relationship_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps

      # add_index :notifications, :visitor_id
      # add_index :notifications, :visited_id
      # add_index :notifications, :favorite_id
      # add_index :notifications, :relationship_id
    end
  end
end
