class AddIsMinorEditToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_minor_edit, :boolean
  end

  def self.down
    remove_column :pages, :is_minor_edit
  end
end
