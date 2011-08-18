class Page < ActiveRecord::Base
  belongs_to :editor, :class_name => "User", :foreign_key => "editor_id"
  belongs_to :markup

  validates :path, :length => { :in => 1 .. 100 }
  validates :title, :length => { :in => 1 .. 100 }
  validates :body, :length => { :in => 1 .. 100000 }
  validates :editor_id, :presence => true
  validates :revision, :uniqueness => { :scope => :path }
  validates :revision, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :markup_id, :presence => true
  
  def self.find_latest_by_path (path)
    readonly.where(:path => path).order(:revision).last
  end
  
  def to_s
    "/#{path}"
  end
end
