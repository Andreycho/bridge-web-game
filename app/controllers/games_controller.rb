class GamesController < ApplicationController
  before_action :authenticate_user!

    def index
        @games = Game.all
    end

    def show
        @game = Game.find(params[:id])
        @deck = Deck.new
        @hand = Hand.new(@deck)
    end

    def new
      @game = Game.create
      if @game.save
        redirect_to game_path(@game)
      else
        render :new, status: :unprocessable_entity
      end
    end
        
    def create
        @game = Game.new(game_params)

      if @game.save
        redirect_to game_path(@game)
      else
        render :new, status: :unprocessable_entity
      end
    end
    #   private
      
    #   def game_params
    #     params.require(:game).permit(:id)
    #   end

    # def index
    #   render :template => 'games/root'
    # end
  
    # def draw
    #   @game = Game.find(session[:game_id])
    #   prev_size = @game.hand.size
    #   @game.draw_card
    #   if @game.hand.size > prev_size then
    #     redirect_to games_path(@game), notice: "You have drawn a card."
    #   else
    #     redirect_to games_path(@game), notice: "You did NOT draw a card."
    #   end
    # end
  
    # def shuffle
    #   Game.find(session[:game_id]).shuffle
    #   redirect_to games_path(@game), notice: "You have re-shuffled the deck."
    # end
  
    # def show
    #   Game.find(session[:game_id]).show
    #   redirect_to games_path(@game), notice: "You have drawn all cards from the deck!"
    # end
  
    # def new
    #   @game = Game.create
    #   @game.shuffle
    #   session[:game_id] = @game.id
    #   redirect_to games_path(@game), notice: "You have created a new game."
    # end
end
