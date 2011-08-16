class UserController < ApplicationController
  def show
    params[:path] ||= ''
  end

end
