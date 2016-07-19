class AddDateToSensors < ActiveRecord::Migration[5.0]
  def change
    add_column :sensors, :datainclusao, :datetime
  end
end
