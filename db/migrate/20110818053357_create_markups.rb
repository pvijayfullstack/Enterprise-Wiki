class CreateMarkups < ActiveRecord::Migration
  def self.up
    create_table :markups do |t|
      t.string :title, :null => false, :limit => 100

      t.timestamps
    end
    
    add_index :markups, :title, :unique => true
  end

  def self.down
    drop_table :markups
  end
end
