class CreateTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :turns do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :card, null: false, foreign_key: true
      t.timestamps
    end
  end
end
