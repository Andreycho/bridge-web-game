class Playable < ApplicationRecord
    validates :game_id, presence: true
    validates :user_id, presence: true

    belongs_to :game
    belongs_to :user
end
