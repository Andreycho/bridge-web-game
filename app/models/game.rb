class Game < ApplicationRecord
    belongs_to :user
    validates :user_id, presence: true

    # before_create :distribute_cards 

  #   attr_reader :cards

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

  def current_trick_cards
    turns = Turn.where(game_id: self.id).order(:created_at).to_a
    turns_count = Turn.where(game_id: self.id).count

    number_of_tricks_passed = turns_count / 4
    first_card_index = 4 * number_of_tricks_passed
    last_card_index = first_card_index + 4
    displaying_cards = turns[first_card_index...last_card_index].pluck(:card_id)
    Card.where(id: displaying_cards)
  # % 4 kolko ostava
  end

  def current_contract
    ContractTurn.where(game_id: self.id).order(:created_at).last(4).first.contract_id
  end

  def is_bidding_finished?
    contract_turns = ContractTurn.where(game_id: self.id).order(:created_at).last(3)
    if(contract_turns.select{|a | a.contract_id == 36}.count == 3)
      self.update(status: "play")
      return true
    else
      return false
    end
  end

  def compare_cards
    cards = current_trick_cards.to_a
  
    if cards.size == 3

      value_map = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14 }
    
      if Contract.find_by(id: current_contract).suit == "no_trump"
        
        cards_by_value = cards.sort_by { |c| value_map[c.value] || c.value.to_i }
        highest_card = cards_by_value.last
      elsif Contract.find_by(id: current_contract).suit == "hearts"
        heart_cards = cards.select { |card| card.suit == "hearts" }
  
        if heart_cards.size > 0
          highest_card = heart_cards.max_by { |c| value_map[c.value] || c.value.to_i }
        else
          cards_by_value = cards.sort_by { |c| value_map[c.value] || c.value.to_i }
          highest_card = cards_by_value.last
        end
      elsif Contract.find_by(id: current_contract).suit == "spades"
        spade_cards = cards.select { |card| card.suit == "spades" }
        if spade_cards.size > 0
          highest_card = spade_cards.max_by { |c| value_map[c.value] || c.value.to_i }
        else
          cards_by_value = cards.sort_by { |c| value_map[c.value] || c.value.to_i }
          highest_card = cards_by_value.last
        end
      elsif Contract.find_by(id: current_contract).suit == "diamonds"
        diamond_cards = cards.select { |card| card.suit == "diamonds" }
        if diamond_cards.size > 0
          highest_card = diamond_cards.max_by { |c| value_map[c.value] || c.value.to_i }
        else
          cards_by_value = cards.sort_by { |c| value_map[c.value] || c.value.to_i }
          highest_card = cards_by_value.last
        end
      end
      
      return highest_card
    else
      return nil
    end
  end

  def tricks_won
    turns = Turn.where(game_id: self.id, card_id: compare_cards, user_id: [1, 3]).count
  end


def is_game_finished?
  turns_count = Turn.where(game_id: self.id).count

  if turns_count == 52
    self.update(status: "finished")
    return true
  else
    return false
  end
end
end
