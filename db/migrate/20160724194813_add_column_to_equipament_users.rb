class AddColumnToEquipamentUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :equipament_users, :user_id, :integer
    add_column :equipament_users, :equipament_id, :integer
  end
end
