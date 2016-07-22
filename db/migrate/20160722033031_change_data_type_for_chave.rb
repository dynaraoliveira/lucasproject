class ChangeDataTypeForChave < ActiveRecord::Migration[5.0]
  def change
    change_column :sensors, :chave, :text
  end
end
