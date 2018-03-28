class Party < ApplicationRecord
  belongs_to :challenge
  has_many :participations
end
