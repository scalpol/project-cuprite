class ParticipationsController < ApplicationController
  def new
    @party = Party.find(params[:party_id])
    @participation = Participation.new()
    @available_orbs = current_player.wallet.orbs
  end

  def create
    @participation = Participation.new(party_id: params[:party_id], player_id: current_player.id, blocks: params[:participation][:blocks].to_i)
    @player = Player.find(current_player.id)
    @challenge = Challenge.find(@participation.challenge.id)
    @orbs = params[:participation][:blocks].to_i * @challenge.block_size
    @party = Party.find(params[:party_id])
    ActiveRecord::Base.transaction do
      begin
        @participation.save
        @player.wallet.update!(orbs: (@player.wallet.orbs - @orbs))
        @challenge.wallet.update!(orbs: (@challenge.wallet.orbs + @orbs))
      rescue ActiveRecord::Rollback
        redirect_to challenge_path(@challenge), alert: "There was a problem joining the challenge."
      end
    end

  end

end
