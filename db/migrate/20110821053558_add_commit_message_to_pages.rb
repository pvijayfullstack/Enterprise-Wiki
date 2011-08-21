class AddCommitMessageToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :commit_message, :string
  end

  def self.down
    remove_column :pages, :commit_message
  end
end
