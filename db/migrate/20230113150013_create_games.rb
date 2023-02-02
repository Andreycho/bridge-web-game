class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :status
      t.string :turn
      t.integer :west_player_id
      t.integer :north_player_id
      t.integer :east_player_id
      t.integer :south_player_id
      
      t.timestamps
    end
  end
end
