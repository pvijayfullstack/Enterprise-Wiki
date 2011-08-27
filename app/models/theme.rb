class Theme < ActiveRecord::Base
  has_many :pages
  
  def to_s
    title
  end
end
