class User < ActiveRecord::Base
  # See http://stackoverflow.com/questions/1226182/
  establish_connection "user_#{RAILS_ENV}"
end
