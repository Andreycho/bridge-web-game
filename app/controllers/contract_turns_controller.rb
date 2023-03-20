class ContractTurnsController < ApplicationController
    def new
        @contract_turn = ContractTurn.new(contract_id: params[:contract_id], game_id: params[:game_id], user_id: current_user.id)
      end

    def create
        @contract_turn = ContractTurn.new(turn_params.merge(user_id: current_user.id))
        if @contract_turn.save
          respond_to do |format|
            format.html { redirect_to game_path(@contract_turn.game), notice: "Successfully created a contract turn." }
            format.turbo_stream{ flash.now[:notice] = "Successfully created a contract turn." }
          end
        else
          render :new
        end
        
      end
    
      private
    
      def turn_params
        params.require(:contract_turn).permit(:contract_id, :game_id)
      end
end
