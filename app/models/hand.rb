class Hand < ApplicationRecord
    belongs_to :user
    belongs_to :game
    # serialize :cards, Array
    has_many :hand_cards
    has_many :cards, through: :hand_cards

    # def initialize(deck)
    #   @deck = deck
    #   @cards = []
    #   # draw(13)
    # end

    # def create()
    #   @cards = []
      
    #   Hand.create(
    #     user: user,
    #     game: game,
    #     cards: deck.pop(13)
    #   )
    # end

    def draw(n)
      n.times do 
        cards << @deck.draw 
      end
    end

    def shuffle 
        @cards.shuffle
    end
  end