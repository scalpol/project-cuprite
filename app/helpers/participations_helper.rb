module ParticipationsHelper

  def participation_save(player, orbs, participation, challenge)
    if player.wallet.orbs >= orbs
      ActiveRecord::Base.transaction do
        begin
          participation.save!
          player.wallet.update!(orbs: (player.wallet.orbs - orbs))
          challenge.wallet.update!(orbs: (challenge.wallet.orbs + orbs))
          player.wallet.orbs > 0
        rescue ActiveRecord::Rollback
          redirect_to challenge_path(challenge), alert: "There was a problem joining the challenge."
        end
      end
    else
      redirect_to challenge_path(challenge), alert: "Not enough orbs!"
    end
  end
end
