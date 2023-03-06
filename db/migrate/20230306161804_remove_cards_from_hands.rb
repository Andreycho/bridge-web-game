class RemoveCardsFromHands < ActiveRecord::Migration[7.0]
  def change
    remove_column :hands, :cards, :string
  end
end
