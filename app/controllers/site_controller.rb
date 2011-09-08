class SiteController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_admin!, :only => [:new_users, :create_users, :pv_stat]
  
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
    @dates_hash = Hash.new(0)
    File.open(Rails.root.join("log", "#{params[:env]}.log")) do |f|
      f.each_line do |line|
        if line.starts_with? "Started"
          date = line.match(/\d\d\d\d-\d\d-\d\d/)[0]
          @dates_hash[date] += 1
        end
      end
    end
  rescue
    @dates_hash = Hash.new
  end

protected
  def must_be_admin!
    redirect_to root_path unless current_user.try(:admin?)
  end

end
