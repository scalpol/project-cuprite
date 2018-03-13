class AddReferencesToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :challenges, :parties, column: :winner_party_id
    add_foreign_key :challenges, :players, column: :creator_id
    add_foreign_key :challenges, :languages, column: :language_id
  end
end
