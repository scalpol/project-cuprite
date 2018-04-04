class Party < ApplicationRecord
  belongs_to :challenge
  has_many :participations
  has_many :confirmations
end
