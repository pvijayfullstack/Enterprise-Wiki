class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string  :username, :null => false, :limit => 40
      t.boolean :admin,    :null => false, :default => false
      
      t.database_authenticatable
      t.token_authenticatable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :time
      t.rememberable
      t.trackable

      t.timestamps
    end

    add_index :users, :username,             :unique => true
    add_index :users, :email,                :unique => true
    add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
