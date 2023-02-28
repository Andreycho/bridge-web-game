class Hand < ApplicationRecord
    belongs_to :user
    belongs_to :game
  
    attr_reader :cards

    # def initialize(deck)
    #   @deck = deck
    #   @cards = []
    #   # draw(13)
    # end

    def self.create_hand_for_user_and_game(user, game, deck)
      Hand.create!(
        user: user,
        game: game,
        cards: deck.pop(13)
      )
    end

    def draw(n)
      n.times do 
        @cards << @deck.draw 
      end
    end

    def shuffle 
        @cards.shuffle
    end
  
    # def sort
    #   @cards.sort! { |a, b| b.order <=> a.order }
    #   self
    # end
  
    # def cards_with_suit(suit)
    #   @cards.select { |card| card.suit == suit }
    # end
  
    # def to_s
    #   @cards.map(&:to_s).join(' ')
    # end
  
    # PBN_ORDER = { 'S' => 'H', 'H' => 'D', 'D' => 'C', 'C' => nil }
  
    # def to_pbn
    #   return '-' if @cards.empty?
  
    #   s = ''
    #   suit = 'S'
    #   sort
    #   @cards.each do |card|
    #     while card.suit != suit
    #       s += '.'
    #       suit = PBN_ORDER[suit]
    #     end
    #     s += card.rank
    #   end
    #   while PBN_ORDER[suit]
    #     s += '.'
    #     suit = PBN_ORDER[suit]
    #   end
    #   s
    # end
  
    # def self.parse_pbn(pbn)
    #   hand = new
    #   return hand if pbn == '-'
  
    #   raise Error, 'All four suits must be declared.' unless pbn.split('.').length == 4
  
    #   suit = 'S'
    #   rank = nil
    #   pbn.each_char do |char|
    #     if char == '.'
    #       suit = PBN_ORDER[suit]
    #     else
    #       hand.cards.push(cards[char + suit])
    #     end
    #   end
    #   hand
    # end
  
    # def hcp
    #   points = { 'A' => 4, 'K' => 3, 'Q' => 2, 'J' => 1 }
    #   @cards.reduce(0) do |acc, card|
    #     acc + (points[card.rank] || 0)
    #   end
    # end
  end