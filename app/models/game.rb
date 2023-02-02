class Game < ApplicationRecord
    has_many :playables
    has_many :users, through: :playables

    enum status: { auction: 0, card_play: 1, finished: 2}
    enum turns: { west: 0, north: 1, east: 2, south: 3 }
    
end
