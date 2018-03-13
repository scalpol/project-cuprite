class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.integer :orbs
      t.boolean :active
      t.references :owner, polymorphic: true, index: true

      t.timestamps
    end
  end
end
