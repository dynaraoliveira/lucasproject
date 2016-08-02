class AddColumnToSensors < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :equipament_id, :integer
    add_index :sensors, :equipament_id, unique: true
  end
end
