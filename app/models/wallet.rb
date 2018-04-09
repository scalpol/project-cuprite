class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  validates :owner_id, uniqueness: {scope: :owner_type}
  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'origin_wallet_id', dependent: :destroy
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'destination_wallet_id', dependent: :destroy
end
