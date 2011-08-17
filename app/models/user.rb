class User < ActiveRecord::Base
  establish_connection "user_#{RAILS_ENV}"
end
