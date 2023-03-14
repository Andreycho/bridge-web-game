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

  def is_my_turn?
    # players = Playable.where(game_id: self.game_id).order(:created_at).to_a
    # my_position = players.index(self)
    # previous_player_id = players[(my_position - 1) % players.count].id

    # last_turn = Turn.joins(:playable).where(playable: { game_id: self.game_id }).last

    # if last_turn.nil? 
    #   return players[0].id == self.id
    # elsif last_turn.playable_id == previous_player_id
    #   return true
    # else
    #   return false
    # end
    players = Playable.where(game_id: self.id).order(:created_at).to_a
    my_position = players.index(self)
    previous_player_id = players[(my_position - 1) % players.count].id

    last_turn = Turn.joins(:game).where(game: { game_id: self.id }).last

    if last_turn.nil? 
      return players[0].id == self.id
    elsif last_turn.playable_id == previous_player_id
      return true
    else
      return false
    end
  end

  # def create_trick_if_needed
  #   if Turn.where(game_id: self.id).count % 4 == 0
  #     trick = Trick.create(game_id: self.id)
  #   end
  # end

  def current_trick_cards
    turns = Turn.where(game_id: self.id).order(:created_at).to_a
    turns_count = Turn.where(game_id: self.id).count
    # turns / 4 -> 2 vzqtki
    # 4 * 2 index[8] zapochva tretata
    # mezhdu 8 i 10 za tretata vzqtka

    number_of_tricks_passed = turns_count / 4
    first_card_index = 4 * number_of_tricks_passed
    last_card_index = first_card_index + 4
    displaying_cards = turns[first_card_index...last_card_index].pluck(:card_id)
    Card.where(id: displaying_cards)
  # % 4 kolko ostava
  end

  def winning_card
    turns = Turn.where(game_id: self.id).order(:created_at).to_a
    turns_count = Turn.where(game_id: self.id).count
    number_of_tricks_passed = turns_count / 4
    first_card_index = 4 * number_of_tricks_passed
    last_card_index = first_card_index + 4
    cards_in_play = turns[first_card_index...last_card_index].pluck(:card_id)
  
    first_card_suit = Card.find(cards_in_play.first).suit
    winning_card = Card.where(id: cards_in_play).where(suit: first_card_suit).order(rank: :desc).first
  
    winning_card
  end
end
