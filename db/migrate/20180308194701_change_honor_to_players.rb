class ChangeHonorToPlayers < ActiveRecord::Migration[5.1]
    def change
        change_column(:players, :honor, :float)
    end
end
