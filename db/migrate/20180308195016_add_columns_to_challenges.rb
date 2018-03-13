class AddColumnsToChallenges < ActiveRecord::Migration[5.1]
  def change
    add_column :challenges, :min_honor, :float, default: 0
    add_column :challenges, :picture, :string
  end
end
