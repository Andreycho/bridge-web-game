class Deck
    attr_reader :cards

    def initialize
        @cards = Card.all.to_a.shuffle
    end

    def count
        @cards.count
    end

    def draw
        @cards.pop(13)
    end
end