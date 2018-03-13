class Tag < ApplicationRecord
  has_many :challenge_tags
  has_many :challenges, through: :challenge_tags
end
