class CreateGamesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :games_users do |t|

      t.timestamps
    end
  end
end
