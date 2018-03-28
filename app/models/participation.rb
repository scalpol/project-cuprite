class Participation < ApplicationRecord
  belongs_to :player
  belongs_to :party
  has_one :challenge, through: :party
  validates :player_id, :blocks, :party_id, presence: true
  validates :blocks, numericality: {greater_than_or_equal_to: 1}
end
