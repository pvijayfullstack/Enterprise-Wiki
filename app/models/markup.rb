class Markup < ActiveRecord::Base
  validates :title, :length => { :in => 1 .. 100 }
  validates :title, :uniqueness => { :case_sensitive => false }
end
