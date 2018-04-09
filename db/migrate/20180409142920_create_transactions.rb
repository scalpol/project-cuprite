class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :orbs
      t.references :origin_wallet
      t.references :destination_wallet

      t.timestamps
    end

    add_foreign_key :transactions, :wallets, column: :origin_wallet_id, primary_key: :id
    add_foreign_key :transactions, :wallets, column: :destination_wallet_id, primary_key: :id
  end
end
