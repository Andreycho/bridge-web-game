class DeleteTableTricks < ActiveRecord::Migration[7.0]
  def change
    drop_table :tricks
  end
end
