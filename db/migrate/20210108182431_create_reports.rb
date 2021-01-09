class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|

      t.string :image_id
      t.string :title
      t.text   :body

      t.timestamps
    end
  end
end
