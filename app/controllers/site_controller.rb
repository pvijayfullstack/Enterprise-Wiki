class SiteController < ApplicationController
  before_filter :authenticate_user!
  
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

end
