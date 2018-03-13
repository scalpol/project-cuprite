class CreateBillings < ActiveRecord::Migration[5.1]
  def change
    create_table :billings do |t|
      t.string :code
      t.string :payment_method
      t.decimal :paid_amount, precision: 8, scale: 2
      t.string :currency
      t.decimal :orb_price, precision: 4, scale: 2
      t.integer :total_orbs
      t.boolean :paid, default: false
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
