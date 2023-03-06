class CreateHandCards < ActiveRecord::Migration[7.0]
  def change
    create_table :hand_cards do |t|
      t.belongs_to :hand, null: false, foreign_key: true
      t.belongs_to :card, null: false, foreign_key: true
      t.timestamps
    end
  end
end
