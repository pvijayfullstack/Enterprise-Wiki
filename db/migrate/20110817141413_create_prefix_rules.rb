class CreatePrefixRules < ActiveRecord::Migration
  def self.up
    create_table :prefix_rules do |t|
      t.integer :role_id
      t.string :prefix
      t.string :action_name

      t.timestamps
    end
  end

  def self.down
    drop_table :prefix_rules
  end
end
