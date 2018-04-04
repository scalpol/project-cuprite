class Confirmation < ApplicationRecord
  belongs_to :player
  belongs_to :party
  has_one :challenge, through: :party
end
