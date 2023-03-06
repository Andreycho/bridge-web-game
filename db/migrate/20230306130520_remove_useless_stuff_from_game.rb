class RemoveUselessStuffFromGame < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :turn, :string
    remove_column :games, :west_player_id, :integer
    remove_column :games, :north_player_id, :integer
    remove_column :games, :east_player_id, :integer
    remove_column :games, :south_player_id, :integer
  end
end
