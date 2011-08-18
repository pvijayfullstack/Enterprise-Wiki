class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string  :path,      :null => false, :limit => 100
      t.string  :title,     :null => false, :limit => 100
      t.text    :body,      :null => false
      t.integer :editor_id, :null => false
      t.integer :revision,  :null => false
      
      t.boolean :is_private,   :default => true, :null => false
      t.boolean :is_protected, :default => true, :null => false
      
      t.integer :markup_id, :null => false

      t.timestamps
    end
    
    add_index :pages, [:path, :revision], :unique => true
  end

  def self.down
    drop_table :pages
  end
end
