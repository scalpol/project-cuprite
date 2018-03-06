class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.references :player, foreign_key: true
      t.integer :orbs, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
