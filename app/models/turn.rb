class Turn < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_one :card
end
