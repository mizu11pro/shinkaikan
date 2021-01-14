# frozen_string_literal: true

class DeviseCreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|

      t.string :title
      t.string :body
      t.string :image_id
      t.string :genre_id
      t.boolean :is_movie,

      t.timestamps
    end
  end
end
