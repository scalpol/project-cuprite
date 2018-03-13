class CreateParties < ActiveRecord::Migration[5.1]
  def change
    create_table :parties do |t|
      t.string :description
      t.integer :weight
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
