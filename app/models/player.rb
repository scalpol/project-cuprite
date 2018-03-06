class Player < ApplicationRecord
  has_one :country
  has_one :level
  has_one :wallet
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :wallet_and_level_assignation

  def wallet_and_level_assignation
    self.level_id = Level.find_by(points_required: 0).id
    # stack to deep?
    Wallet.create(player_id: self.id)
  end
end
