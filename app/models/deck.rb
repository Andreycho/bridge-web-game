require_relative './card'

class Deck

    attr_reader :cards

    def initialize
        @cards = []
        Card.suits.each do |suit|
            Card.values.each do |value|
                @cards << Card.new(suit, value)
            end
        end
    end

    def count
        @cards.count
    end

    def shuffle!
        @cards.shuffle!
    end

    def draw
        @cards.pop
    end
end

class Hand
    attr_reader :cards

    def initialize
        @cards = []
    end

    def add_card(card)
        @cards << card
    end


end

class BridgeGame
    def initialize
      @deck = Deck.new
      @north = Hand.new
      @east = Hand.new
      @south = Hand.new
      @west = Hand.new
    end
  
    def deal
      13.times do
        @north.add_card(@deck.deal)
        @east.add_card(@deck.deal)
        @south.add_card(@deck.deal)
        @west.add_card(@deck.deal)
      end
    end
end
