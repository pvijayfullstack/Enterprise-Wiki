require 'digest/md5'

class User < ActiveRecord::Base
  NAME_LENGTH = 4 .. 40
  NAME_FORMAT = /\A[A-Za-z][A-Za-z0-9_.]+\z/
  
  validates :name, :length => { :in => NAME_LENGTH }
  validates :name, :format => { :with => NAME_FORMAT }
  validates :name, :uniqueness => { :case_sensitive => false }
  validates :digest, :length => { :is => 32 }
  
  def password= (pass)
    self.digest = Digest::MD5::hexdigest([name, ApplicationController::REALM, pass].join(":"))
  end
  
  def to_s
    name
  end
  
  def super_user?
    # TODO consider super list
    name == "root"
  end
  
  def can_edit? (path)
    if super_user?
      true
    elsif path.starts_with? "~"
      "#{path}/".starts_with? "~#{name}/"
    else
      # TODO consider black list
      true
    end
  end
end
