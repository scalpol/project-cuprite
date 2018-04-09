class ConfirmationsController < ApplicationController
  authorize_resource

  def create
    @confirmation = Confirmation.new(player: current_player, party_id: params[:party_id])
    if @confirmation.save
      redirect_to challenge_path(Party.find(params[:party_id]).challenge.id), notice: "Confirmation sent"
    else
      redirect_to challenge_path(params[:challenge_id]), akert: "Confirmation couldn't be saved"
    end
  end
end
