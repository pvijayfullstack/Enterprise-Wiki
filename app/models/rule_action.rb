class RuleAction < ActiveRecord::Base
  validates :title, :length => { :in => 1 .. 40 }
  validates :title, :uniqueness => { :case_sensitive => false }
  
  def to_s
    title.gsub(/[^_A-Za-z0-9]/, '')
  end
  
  def is (other)
    to_s.downcase == other.to_s.downcase
  end
end
