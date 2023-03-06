class GamesController < ApplicationController
  before_action :authenticate_user!

    def index
        @games = Game.all
    end

    # def show
    #     @game = Game.find(params[:id])
    #     @deck = Deck.new
    #     @hand = Hand.new(@deck)
    #     @hand = @game.hands.find_by(user_id: current_user.id)
    #     ActionCable.server.broadcast "game_#{@game.id}", hand: @hand.cards
    # end

    # def show
    #   @game = Game.find(params[:id])
    #   @deck = Deck.new
    #   @hand = @game.hands.find_by(user_id: current_user.id)
    #   unless @hand
    #     @hand = Hand.new(@deck)
    #     @hand.user = current_user
    #     @hand.game = @game
    #     @hand.save
    #   end
    #   ActionCable.server.broadcast "game_#{@game.id}", hand: @hand.cards
    # end

    def show
      @game = Game.find(params[:id])
      @current_user_hand = Hand.find_by(game: @game, user: current_user)
      # debugger
      # @deck = Card.all.to_a.shuffle
      # @hand = @game.hands.find_or_initialize_by(user_id: current_user.id)
      # @hand.user = current_user
      # @hand.cards = @deck.pop(13)
      # @hand.save!
      # ActionCable.server.broadcast "game_#{@game.id}", hand: @hand.cards
      player_count = Playable.where(game_id: @game.id).count

      if player_count == 4
        players = User.limit(4)
        deck = Card.all.to_a.shuffle
        @hands = players.map do |player|
          hand = Hand.create(game: @game, user: player, cards: deck.pop(13))
          hand
        end
      end
    end

    def new
      @game = Game.create
      if @game.save
        redirect_to game_path(@game)
      else
        render :new, status: :unprocessable_entity
      end
      @game.distribute_cards
      # ActionCable.server.broadcast "game_#{@game.id}", hands: @game.hands
    end
        
    # def create
    #     @game = Game.new()

    #   if @game.save
    #     redirect_to game_path(@game)
    #   else
    #     render :new, status: :unprocessable_entity
    #   end
    # end

    def create
      @game = Game.new(user_id: current_user.id)

      if @game.save
        # players = User.limit(4)
        # deck = Card.all.to_a.shuffle
        # hands = players.map do |player|
        #   hand = Hand.create(game: @game, user: player, cards: deck.pop(13))
        #   hand
        # end
        # hands.each do |hand|
        #   broadcast_cards(hand, "game_channel_#{hand.user.id}")
        # end
        redirect_to @game, notice: "Successfully created game."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def broadcast_cards(hand, channel = 'game_channel')
      # @hand = hand
      # turbo_stream.append 'cards', partial: 'cards', locals: { hand: hand }
      @hand = hand
      turbo_stream.append "#{channel}_#{hand.user.id}", partial: 'hand', locals: { hand: hand }
    end
    
      private
      
      def game_params
        params.require(:game).permit(:id)
      end
    end
