class CreateIndexSensors < ActiveRecord::Migration[5.0]
  def change
    add_index :sensors, :chave
  end
end
