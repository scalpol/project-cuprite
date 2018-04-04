class CreateConfirmations < ActiveRecord::Migration[5.1]
  def change
    create_table :confirmations do |t|
      t.references :player, foreign_key: true, null: false
      t.references :party, foreign_key: true, null: false

      t.timestamps
    end
  end
end
