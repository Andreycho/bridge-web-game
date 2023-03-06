class RemoveStatusFromGame < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :status, :string
  end
end
