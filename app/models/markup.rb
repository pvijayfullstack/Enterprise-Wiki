class Markup < ActiveRecord::Base
  validates :title, :length => { :in => 1 .. 100 }
  validates :title, :uniqueness => { :case_sensitive => false }
  
  def to_sym
    title.gsub(/[^_A-Za-z0-9]/, '').downcase.to_sym
  end
end
