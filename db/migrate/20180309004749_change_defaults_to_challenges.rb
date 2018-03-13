class ChangeDefaultsToChallenges < ActiveRecord::Migration[5.1]
  def change
    change_column :challenges, :status, :integer, default: 0
  end
end
