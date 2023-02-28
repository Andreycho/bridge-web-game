class AddGameIdToHands < ActiveRecord::Migration[7.0]
  def change
    add_column :hands, :game_id, :integer
  end
end
