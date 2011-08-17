require 'digest/md5'

class User < ActiveRecord::Base
  validates :name, :digest, :presence => true
  
  def self.realm
    Rails.application.config.realm
  end
  
  def password=(pass)
    self.digest = Digest::MD5::hexdigest([name, User.realm, pass].join(":"))
  end
end
