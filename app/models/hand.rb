class Hand < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_many :hand_cards
    has_many :cards, through: :hand_cards

    def draw(n)
      n.times do 
        cards << @deck.draw 
      end
    end

    def shuffle 
        @cards.shuffle
    end

    def current_cards
      @played_cards = Turn.where(game_id: game.id, user_id: user.id).pluck(:card_id)
      @remaining_cards = cards.pluck(:id) - @played_cards
      Card.where(id: @remaining_cards)
    end
  end