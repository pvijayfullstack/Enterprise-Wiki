class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :path
      t.string :title
      t.text :body
      t.string :editor
      t.integer :revision

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
