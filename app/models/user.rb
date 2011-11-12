class User < ActiveRecord::Base
  has_many :pages, :foreign_key => "editor_id"
  has_and_belongs_to_many :roles
  
  validates :username, :length => { :in => 2 .. 40 }
  validates :username, :format => { :with => /\A[-A-Za-z][-A-Za-z0-9_.]+\z/ }
  validates :username, :uniqueness => { :case_sensitive => false }
  
  # Include default devise modules. Others available are:
  # :encryptable, :confirmable, :recoverable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :lockable, :rememberable, :trackable, :validatable, #:registerable,
         :authentication_keys => [:username]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :admin
  
  def homepage
    "/~#{username}"
  end
  
  def to_s
    username
  end
  
  def name
    username
  end
  
  def title
    username
  end
  
  def prefix_rules
    roles.collect(&:prefix_rules).flatten
  end
  
  def can_show? (path)
    can? :show, path
  end
  
  def can_edit? (path)
    can? :edit, path
  end
  
  def can_upload? (path)
    can? :upload, path
  end
  
  def can? (action, path)
    if admin?
      true
    else
      prefix_rules.each do |rule|
        if rule.allow?(action, path)
          return true
        end
      end
      path_owned?(path)
    end
  end

protected
  def path_owned? (path)
    path.starts_with? "~" and "#{path}/".starts_with? "~#{username}/"
  end
  
end
