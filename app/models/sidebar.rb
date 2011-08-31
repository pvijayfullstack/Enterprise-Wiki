class Sidebar < ActiveRecord::Base
  belongs_to :markup
  
  validates :path, :length => { :in => 1 .. 100 }
  validates :path, :uniqueness => true
  validates :body, :length => { :in => 1 .. 100000 }
  validates :markup_id, :presence => true
end
