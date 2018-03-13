class CreateChallengeTags < ActiveRecord::Migration[5.1]
  def change
    create_table :challenge_tags do |t|
      t.references :challenge, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
