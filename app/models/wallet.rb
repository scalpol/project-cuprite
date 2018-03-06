class Wallet < ApplicationRecord
  belongs_to :player
  validates :player_id, uniqueness: true
end
