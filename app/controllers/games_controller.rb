class GamesController < ApplicationController
  before_action :authenticate_user!

    def index
        @games = Game.all
    end

    def show
      @game = Game.find(params[:id])
      @contracts = Contract.all
      player_count = Playable.where(game_id: @game.id).count

      if player_count == 4
        players = User.limit(4)
        deck = Card.all.to_a.shuffle
        @hands = players.map do |player|
          hand = Hand.create(game: @game, user: player, cards: deck.pop(13))
          hand
        end
        @current_user_hand = Hand.find_by(game: @game, user: current_user)
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
    end

    def create
      @game = Game.new(user_id: current_user.id)

      if @game.save
        redirect_to @game, notice: "Successfully created game."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # def history
    #   @games = Game.order(created_at: :desc)
    #   @turns = Turn.where(game_id: )
    # end
    
      private
      
      def game_params
        params.require(:game).permit(:id)
      end
    end
