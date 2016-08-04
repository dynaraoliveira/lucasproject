class DropColumnToSensors < ActiveRecord::Migration[5.0]
  def change
    remove_index :sensors, :equipament_id
    remove_column :sensors, :equipament_id
  end
end
