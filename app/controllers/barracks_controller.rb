class BarracksController < ApplicationController

  def created
    @challenges = current_player.created
  end

  def participations
    @challenges = current_player.current_participations
  end

  def important
    @challenges = current_player.requiring_attention
  end

  def archived
    @challenges = current_player.archived_challenges
  end

end
