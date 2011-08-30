class PrefixRule < ActiveRecord::Base
  belongs_to :role
  belongs_to :rule_action
  
  validates :role_id, :presence => true
  validates :rule_action_id, :presence => true
  validates :prefix, :length => { :in => 1 .. 100 }
  
  def prefix
    self[:prefix].to_s.strip.downcase
  end
  
  def title
    "#{rule_action.title.capitalize} #{prefix}"
  end
  
  def allow? (action, path)
    rule_action.is(action) and "#{path}/".starts_with? "#{URI.escape(PageHelper.slugify(prefix))}/"
  end
end
