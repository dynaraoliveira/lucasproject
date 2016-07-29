class ChangeDataTypeForSensorChave < ActiveRecord::Migration[5.0]
  def change
    change_column :sensors, :chave, :string
  end
end
