class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :title, :null => false, :limit => 100

      t.timestamps
    end
    
    add_index :roles, :title, :unique => true
  end

  def self.down
    drop_table :roles
  end
end
