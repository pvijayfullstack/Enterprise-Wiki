class AddSecretBeforeToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :secret_before, :datetime
  end

  def self.down
    remove_column :pages, :secret_before
  end
end
