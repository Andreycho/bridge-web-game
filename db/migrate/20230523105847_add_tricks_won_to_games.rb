class AddTricksWonToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :tricks_won, :integer, default: 0
  end
end
