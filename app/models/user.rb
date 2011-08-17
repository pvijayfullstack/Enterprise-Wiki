class User < ActiveRecord::Base
  validates :user_name, :digest_hash, :presence => true
end
