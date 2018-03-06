class CreateLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :levels do |t|
      t.string :name
      t.string :picture
      t.integer :points_required

      t.timestamps
    end
  end
end
