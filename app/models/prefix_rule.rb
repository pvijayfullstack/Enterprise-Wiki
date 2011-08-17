class PrefixRule < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :prefix, :length => { :in => 1 .. 100 }
end
