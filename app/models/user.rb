class User < ActiveRecord::Base
  has_many :pages, :foreign_key => "editor_id"
  
  validates :username, :length => { :in => 4 .. 40 }
  validates :username, :format => { :with => /\A[A-Za-z][A-Za-z0-9_.]+\z/ }
  validates :username, :uniqueness => { :case_sensitive => false }
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :lockable, :rememberable, :trackable, :validatable, :registerable,
         :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  
  def to_s
    username
  end
  
  def can_edit? (path)
    if admin?
      true
    elsif path.starts_with? "~"
      "#{path}/".starts_with? "~#{username}/"
    else
      # TODO consider black list
      true
    end
  end
end
