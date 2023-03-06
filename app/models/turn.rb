class Turn < ApplicationRecord
    belongs_to :user
    has_one :card
end
