class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => :sitemap
  before_filter :must_be_admin!, :only => [:new_users, :create_users, :pv_stat]
  
  def sitemap
    @paths_and_titles = list_pages
    render :sitemap
  end
  
  def edit_password
    render :password
  end
  
  def save_password
    new_pass = params[:new_password]
    confirm = params[:confirm_password]
    if new_pass and confirm and new_pass == confirm
      current_user.password = new_pass
      if current_user.save
        redirect_to root_path
      else
        # TODO render errors
        render :password
      end
    else
      render :password
    end
  end
  
  def list_users
    @users = User.all
    render :list_users
  end
  
  def new_users
    render :new_users
  end
  
  def create_users
    @user_list = params[:user_list]
    if @user_list and not @user_list.blank?
      @user_list.each_line do |line|
        email, username, passwd = line.split
        user = User.new(:email => email, :username => username, :password => passwd)
        if user.save
          UserMailer.welcome_email(user, passwd).deliver
        else
          # TODO record error
        end
      end
      
      redirect_to "/site/users"
    else
      render :new_users
    end
  end
  
  def pv_stat
    @start_time = Time.new
    @dates_hash = Hash.new(0)
    @log_file = Rails.root.join("log", "#{params[:env]}.log")
    
    dates = `grep -o -P "\\d\\d\\d\\d-\\d\\d-\\d\\d" #{@log_file}`.split(/\n/)
    i = 0
    while i < dates.size
      date = dates[i]
      j = i + 1
      while j < dates.size and dates[j] == date
        j += 1
      end
      @dates_hash[date] = j - i
      i = j
    end
    
    @end_time = Time.new
  rescue
    @error = true
    @end_time = Time.new
  end

protected
  def must_be_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end
  
  def list_pages
    Page.all.collect(&:path).uniq.collect do |path|
      [path, Page.find_latest_by_path(path).title]
    end
  end

end
