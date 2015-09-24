class Admin::SessionsController < ApplicationController

  def login
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to admin_cats_path
    else
      redirect_to admin_login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to admin_login_path
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end