class PrefixRule < ActiveRecord::Base
  belongs_to :role
  
  validates :role_id, :presence => true
  validates :prefix, :length => { :in => 1 .. 100 }
  validates :action_name, :inclusion => { :in => %w(show edit) }
  
  def title
    "#{action_name.capitalize} #{prefix}"
  end
end
