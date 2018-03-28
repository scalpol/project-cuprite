class CreateParticipations < ActiveRecord::Migration[5.1]
  def change
    create_table :participations do |t|
      t.integer :blocks
      t.references :player, foreign_key: true
      t.references :party, foreign_key: true

      t.timestamps
    end
  end
end
