class RemovePicturesFromPlayersAndChallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :picture
    remove_column :challenges, :picture
  end
end
