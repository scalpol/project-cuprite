class CreateVerifiers < ActiveRecord::Migration[5.1]
  def change
    create_table :verifiers do |t|
      t.string :description
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
