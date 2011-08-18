class AddRestrictionsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_private,   :boolean, :default => true
    add_column :pages, :is_protected, :boolean, :default => true
  end

  def self.down
    remove_column :pages, :is_protected
    remove_column :pages, :is_private
  end
end
