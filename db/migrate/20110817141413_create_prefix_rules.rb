class CreatePrefixRules < ActiveRecord::Migration
  def self.up
    create_table :prefix_rules do |t|
      t.integer :role_id,        :null => false
      t.integer :rule_action_id, :null => false
      t.string  :prefix,         :null => false, :limit => 100

      t.timestamps
    end
    
    add_index :prefix_rules, [:role_id, :rule_action_id, :prefix], :unique => true
  end

  def self.down
    drop_table :prefix_rules
  end
end
