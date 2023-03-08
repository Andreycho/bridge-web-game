class AddPlayableIdToTurns < ActiveRecord::Migration[7.0]
  def change
    add_column :turns, :playable_id, :integer
  end
end
