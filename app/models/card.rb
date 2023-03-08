class Card < ApplicationRecord
    has_many :hand_cards
    has_many :hands, through: :hand_cards
    # belongs_to :turn
end
