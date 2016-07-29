class CreateEquipamentUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :equipament_users do |t|

      t.timestamps
    end
  end
end
