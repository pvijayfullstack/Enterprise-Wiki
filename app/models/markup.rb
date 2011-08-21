class Markup < ActiveRecord::Base
  validates :title, :length => { :in => 1 .. 100 }
  validates :title, :uniqueness => { :case_sensitive => false }
  
  def to_sym
    title.gsub(/\s+/, '_').gsub(/[^_A-Za-z0-9]/, '').downcase.to_sym
  end
  
  def is? (sym)
    to_sym == sym
  end
end
