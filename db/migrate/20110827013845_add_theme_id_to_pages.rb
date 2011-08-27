class AddThemeIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :theme_id, :integer
  end

  def self.down
    remove_column :pages, :theme_id
  end
end
