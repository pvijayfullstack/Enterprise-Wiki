class CreateRuleActions < ActiveRecord::Migration
  def self.up
    create_table :rule_actions do |t|
      t.string :title, :null => false, :limit => 40

      t.timestamps
    end
    
    add_index :rule_actions, :title, :unique => true
  end

  def self.down
    drop_table :rule_actions
  end
end
