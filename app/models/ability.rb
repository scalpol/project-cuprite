class Ability
  include CanCan::Ability

  def initialize(player)

    player ||= Player.new
    if player.present?
      can :read, Challenge
      can :manage, Challenge, creator_id: player.id
      can :manage, [Participation, Confirmation], player: player.id
    end

  end
end
