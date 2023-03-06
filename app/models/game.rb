class Game < ApplicationRecord
    belongs_to :user

    validates :user_id, presence: true

    # before_create :distribute_cards 

  #   attr_reader :cards

  #   enum status: { auction: 0, card_play: 1, finished: 2}
  #   enum turns: { west: 0, north: 1, east: 2, south: 3 }

  # serialize :deck, Array
  # serialize :hand, Array

  def distribute_cards
    players = User.limit(4)
    deck = Card.all.to_a.shuffle
    players.each do |player|
      Hand.create_hand_for_user_and_game(player, self, deck)
    end
  end

  # def distribute_cards
  #   players = User.limit(4)
  #   cards = Card.all.to_a.shuffle
  #   hands = players.map do |player|
  #     hand = Hand.new(game: self, user: player)
  #     hand.cards = cards.shift(13)
  #     hand.save!
  #   end
  # end
#   def shuffle
#     new_random_deck
#     self.save
#   end
 
end
