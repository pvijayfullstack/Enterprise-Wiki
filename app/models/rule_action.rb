class RuleAction < ActiveRecord::Base
  validates :title, :length => { :in => 1 .. 40 }
  validates :title, :uniqueness => { :case_sensitive => false }
  
  def is (action)
    title.downcase == action.to_s.downcase
  end
end
