class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :description
      t.boolean :local
      t.integer :capped
      t.integer :status
      t.integer :block_size
      t.datetime :closing_date
      t.datetime :expiration_date
      t.references :language
      t.references :winner_party
      t.references :creator

      t.timestamps
    end
  end
end
