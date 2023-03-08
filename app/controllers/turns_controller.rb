class TurnsController < ApplicationController
      def new
        @turn = Turn.new(card_id: params[:card_id], playable_id: params[:game_id], user_id: current_user.id)
      end

    def create
        @turn = Turn.new(turn_params.merge(user_id: current_user.id))
        if @turn.save
          respond_to do |format|
            format.html { redirect_to game_path(@turn.game), notice: "Successfully created a turn." }
            format.turbo_stream{ flash.now[:notice] = "Successfully created a turn." }
          end
        else
          render :new
        end
        
      end
    
      private
    
      def turn_params
        params.require(:turn).permit(:card_id, :game_id)
      end
end
