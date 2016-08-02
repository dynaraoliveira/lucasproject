class AddIndexToEquipamentsChave < ActiveRecord::Migration[5.0]
  def change
    add_index :equipaments, :chave, unique: true
  end
end
