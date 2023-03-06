class DeleteTableGamesUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :games_users
  end
end
