class Player < ApplicationRecord
  belongs_to :country
  belongs_to :level, optional: true
  has_one :wallet, as: :owner
  has_many :billings
  has_many :created_challenges, class_name: 'Challenge', foreign_key: 'creator_id'
  has_many :participations
  has_many :confirmations
  validates :username, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :wallet_and_level_assignation
  has_one_attached :profile_picture

  def wallet_and_level_assignation
    self.level_id = Level.find_by(points_required: 0).id
    Wallet.create(owner: self, active: true, orbs: 0)
  end

  def cart
    self.billings.find_by(paid: false)
  end
end
