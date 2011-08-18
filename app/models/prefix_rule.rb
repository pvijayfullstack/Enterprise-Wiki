class PrefixRule < ActiveRecord::Base
  belongs_to :role
  belongs_to :rule_action
  
  validates :role_id, :presence => true
  validates :rule_action_id, :presence => true
  validates :prefix, :length => { :in => 1 .. 100 }
  
  def title
    "#{rule_action.title.capitalize} #{prefix}"
  end
end
