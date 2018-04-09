class Transaction < ApplicationRecord
  belongs_to :origin_wallet, class_name: 'Wallet'
  belongs_to :destination_wallet, class_name: 'Wallet'
end
