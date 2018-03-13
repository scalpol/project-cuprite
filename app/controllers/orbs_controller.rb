class OrbsController < ApplicationController
  def index
    @current_orbs = current_player.wallet.orbs
  end
end
