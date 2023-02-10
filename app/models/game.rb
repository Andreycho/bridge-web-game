class Game < ApplicationRecord
    has_many :playables
    has_many :users, through: :playables

    enum status: { auction: 0, card_play: 1, finished: 2}
    enum turns: { west: 0, north: 1, east: 2, south: 3 }

  serialize :deck, Array
  serialize :hand, Array

#   def shuffle
#     new_random_deck
#     self.save
#   end

#   def size
#     self.hand.size
#   end

#   # A card is drawn from the top of deck (last in array) and put in the hand.
#   def draw_card
#     unless self.deck.empty?
#       self.hand.push(self.deck.pop)
#       self.save
#     end
#   end

#   # show: take all the cards from deck and put them in the hand
#   def show
#     self.deck.size.times do
#       self.draw_card
#     end
#     self.save
#   end

#   def suit(card_num)
#     suits = [ 'Ace', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine',
#               'Ten', 'Jack', 'Queen', 'King' ]
#     unless (card_num > 12) && (card_num < 0) then
#       return suits[card_num]
#     else
#       return nil
#     end
#   end

#   ###########
#   private

#   def card_ref
#     # A unique number for each card.
#     # h = hearts, c = clubs, d = diamonds, s = spades
#     # 1 = ace, 2 -> 10 = number cards, 11 = jack, 12 = queen, 13 = king
#     [ 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'h7', 'h8', 'h9', 'h10', 'h11', 'h12', 'h13',
#       'c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9', 'c10', 'c11', 'c12', 'c13',
#       'd1', 'd2', 'd3', 'd4', 'd5', 'd6', 'd7', 'd8', 'd9', 'd10', 'd11', 'd12', 'd13',
#       's1', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9', 's10', 's11', 's12', 's13' ]
#   end

#   def new_random_deck
#     self.hand = []
#     self.deck = self.card_ref.shuffle
#     self.save
#   end
    
end
