class RemoveActiveAdmin < ActiveRecord::Migration[5.1]
  def change
    drop_table :active_admin_comments
    drop_table :admin_users
  end
end