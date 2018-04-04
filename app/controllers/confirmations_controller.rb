class ConfirmationsController < ApplicationController
  def create
    @confirmation = Confirmation.new(player: current_player, party_id: params[:party_id])
    #agregarle else
    if @confirmation.save
      redirect_to challenge_path(Party.find(params[:party_id]).challenge.id), notice: "Confirmation sent"
    end
  end
end
