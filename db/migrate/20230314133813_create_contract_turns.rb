class CreateContractTurns < ActiveRecord::Migration[7.0]
  def change
    create_table :contract_turns do |t|
      t.belongs_to :game, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
