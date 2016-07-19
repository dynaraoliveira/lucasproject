class CreateSensors < ActiveRecord::Migration[5.0]
  def change
    create_table :sensors do |t|
      t.string :chave
      t.integer :sensor0
      t.integer :sensor1
      t.integer :sensor2
      t.integer :sensor3
      t.integer :sensor4
      t.integer :sensor5

      t.timestamps
    end
  end
end
