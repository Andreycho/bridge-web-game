class Deck
    attr_reader :cards

    def initialize
        @cards = Card.all.to_a.shuffle
        # Card.suits.each do |suit|
        #     Card.values.each do |value|
        #         @cards << Card.new(suit, value)
        #     end
        # end
    end

    def count
        @cards.count
    end

    def draw
        @cards.pop
    end
end