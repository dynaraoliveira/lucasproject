class CreateEquipamentsUsersJoin < ActiveRecord::Migration[5.0]
  def self.up
    create_table 'equipaments_users', :id => false do |t|
      t.column 'equipament_id', :integer
      t.column 'user_id', :integer
    end
  end

  def self.down
    drop_table 'posts_tags'
  end
end
