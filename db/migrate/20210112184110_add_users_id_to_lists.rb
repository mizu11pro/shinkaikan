class AddUsersIdToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :string
    add_column :users, :movie_id, :integer
  end
end
