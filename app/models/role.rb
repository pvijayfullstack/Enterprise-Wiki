class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :prefix_rules
  
  validates :title, :length => { :in => 1 .. 100 }
  validates :title, :uniqueness => { :case_sensitive => false }
  
  def to_s
    title.gsub(/[^_A-Za-z0-9]/, '')
  end
  
  def is (other)
    to_s.downcase == other.to_s.downcase
  end
end
