class CreateEquipaments < ActiveRecord::Migration[5.0]
  def change
    create_table :equipaments do |t|
      t.string :chave
      t.string :nome
      t.string :cidade
      t.string :estado

      t.timestamps
    end
  end
end
