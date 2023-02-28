class PlayablesController < ApplicationController
    def index
    end
  
    def show
    end
  
    def new
      @playable = Playable.new(game_id: params[:game_id], user_id: current_user.id)
    end
  
    def create
      @playable = Playable.new(playable_params.merge(user_id: current_user.id))
  
      # if current_user.game_id.present?
      #   redirect_to game_path(current_user.game_id), alert: "You are already in another game."
      #   return
      # end
      
      if @playable.save
        respond_to do |format|
          format.html { redirect_to game_path(@playable.game), notice: "Successfully joined game." }
          format.turbo_stream{ flash.now[:notice] = "Successfully joined game." }
        end
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
    end
  
    def destroy
    end
  
    def playable_params
      params.require(:playable).permit(:game_id)
    end
end
