class AddRootUser < ActiveRecord::Migration
  def self.up
    User.create(:name => "root", :password => "root")
  end

  def self.down
    User.find_by_name("root").destroy
  end
end
