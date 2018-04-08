class Party < ApplicationRecord
  belongs_to :challenge
  has_many :participations, dependent: :destroy
  has_many :confirmations, dependent: :destroy
end
