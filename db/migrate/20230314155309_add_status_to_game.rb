class AddStatusToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :status, :string, default: 'bidding'
  end
end
