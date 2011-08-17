class User < ActiveRecord::Base
  validates :name, :digest, :presence => true
end
