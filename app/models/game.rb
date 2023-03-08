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

  def is_current_turn?
    players = Playable.where(game_id: self.game_id).order(:created_at).to_a
    my_position = players.index(self)
    previous_player_id = players[(my_position - 1) % players.count].id

    last_turn = Turn.joins(:games_user).where(games_users: { game_id: self.game_id }).last

    if last_turn.nil? 
        return players[0].id == self.id
    elsif last_turn.games_user_id == previous_player_id
        return true
    else
        return false
    end
  end
end
