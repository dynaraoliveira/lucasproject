class DropEquipamentsUsersTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :equipaments_users
  end
end
