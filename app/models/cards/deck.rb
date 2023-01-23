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

    def draw(n)
        drawn_cards = []
        n.times do
            raise "not enough cards" if @cards.empty? or n > @cards.count
            drawn_cards << @cards.pop
        end
        drawn_cards
    end

end