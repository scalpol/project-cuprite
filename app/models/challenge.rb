class Challenge < ApplicationRecord

  validates :title, :description, :closing_date, :expiration_date, :block_size, :creator_id, presence: true
  validates :min_honor, :capped, :block_size, numericality: {greater_than_or_equal_to: 0}
  belongs_to :language
  belongs_to :creator, class_name: 'Player', foreign_key: 'creator_id'
  has_one :wallet, as: :owner, dependent: :destroy
  has_many :challenge_tags, dependent: :destroy
  has_many :tags, through: :challenge_tags
  has_many :verifiers, dependent: :destroy
  has_many :parties, dependent: :destroy
  has_many :participations, through: :parties
  has_many :confirmations, through: :parties
  accepts_nested_attributes_for :verifiers
  accepts_nested_attributes_for :parties
  has_one_attached :picture
  enum status:{
    pending: 0,
    open: 1,
    closed: 2,
    confirming_results: 3,
    on_case: 4,
    archived: 5
  }
  validate :datetime, on: :create
  after_create :wallet_assignation

  def self.status_checker
    challenges = Challenge.where.not(status: 'archived')
    challenges.each do |challenge|
      if challenge.pending? && ((Time.current - challenge.created_at) / 1.hour) > 72
        challenge.destroy
      elsif challenge.open? && challenge.closing_date < Time.current
        challenge.closed!
      elsif (challenge.closed? || challenge.open?) && challenge.expiration_date < Time.current
        challenge.confirming_results!
      elsif challenge.confirming_results? && ((Time.current - c.created_at) / 1.hour) > 48
        if challenge.agreement?
          challenge.distribute_and_archive
        else
          challenge.open_case
        end
      end
    end
  end

  def agreement?
    party = self.confirmations.first.party_id
    self.confirmations.each do |confirmation|
      return false if party != confirmation.party_id
      party = confirmation.party_id
    end
    self.confirmations.first.party.update(winner: true)
    true
  end

  def distribute_and_archive
    winners = {}
    winner_blocks = 0
    total_blocks = 0
    self.participations.each do |participation|
      total_blocks += participation.blocks
      if participation.party.winner == true
        if winners.key?(participation.player_id)
          winners[participation.player_id] += participation.blocks
        else
          winners[participation.player_id] = participation.blocks
        end
        winner_blocks += participation.blocks
      end
    end
    excedent = 0
    winners.each do |player_id, blocks|
      proportion = winner_blocks / blocks.to_f
      if total_blocks * proportion % 1 > 0
        part = (total_blocks * proportion).floor
        excedent += total_blocks * proportion % 1
        self.send_orbs((part * self.block_size).to_i, Player.find(player_id).wallet)
        self.send_orbs((excedent * self.block_size).floor.to_i, Player.find_by(email: 'claudio@claudio.com').wallet)
      else
        part = total_blocks * proportion
        self.send_orbs((part * self.block_size).to_i, Player.find(player_id).wallet)
      end
    end
    self.archived!
  end

  def send_orbs(orbs, destination)
    Transaction.create(orbs: orbs, origin_wallet: self.wallet, destination_wallet: destination)
    self.wallet.update(orbs: (self.wallet.orbs - orbs))
    destination.update(orbs: (destination.orbs + orbs))
  end

  def open_case
    #por hacer
  end

  def winner_party
    self.parties.each do |party|
      return party if party.winner == true
    end
    nil
  end

  def winner?(player)
    winner_party = self.winner_party
    player.participations.select { |p| p if p.challenge.archived? }
    participations.each do |p|
      return true if p.party == winner_party
    end
    false
  end

  def confirmed?(player)
    player.confirmations.each do |confirmation|
      return true if confirmation.challenge == self
    end
    false
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def blocks_in_play
    blocks = 0
    self.participations.each do |participation|
      blocks += participation.blocks
    end
    blocks
  end

  def remaining_blocks
    if self.capped == 0
      return false
    else
      self.capped - blocks_in_play
    end
  end

  private

  def wallet_assignation
    Wallet.create(owner: self, active: true, orbs: 0)
  end

  def datetime
    now = DateTime.now
    if expiration_date < now
      errors.add(:expiration_date, "can't be in the past")
    elsif closing_date < now
      errors.add(:closing_date, "can't be in the past")
    elsif expiration_date < closing_date
      errors.add(:expiration_date, "can't occur before the closing date")
    end
  end

end
