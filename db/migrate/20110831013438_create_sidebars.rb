class CreateSidebars < ActiveRecord::Migration
  def self.up
    create_table :sidebars do |t|
      t.string  :path,      :null => false, :limit => 100
      t.text    :body,      :null => false
      t.integer :markup_id, :null => false

      t.timestamps
    end
    
    add_index :sidebars, :path, :unique => true
  end

  def self.down
    drop_table :sidebars
  end
end
