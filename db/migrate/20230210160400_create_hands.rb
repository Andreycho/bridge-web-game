class CreateHands < ActiveRecord::Migration[7.0]
  def change
    create_table :hands do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :cards, array: true, default: [].to_yaml
      t.timestamps
    end
  end
end
