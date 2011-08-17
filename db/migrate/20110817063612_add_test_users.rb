class AddTestUsers < ActiveRecord::Migration
  def self.up
    1.upto(9) {|i| User.create(:name => "test#{i}", :password => "test") }
  end

  def self.down
    1.upto(9) {|i| User.find_by_name("test#{i}").destroy }
  end
end
