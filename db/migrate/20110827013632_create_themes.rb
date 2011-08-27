class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :title, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :themes
  end
end
