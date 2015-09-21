class Admin::SessionsController < ApplicationController

  def login
    # this will show a login page

  end

  def create

    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      redirect_to admin_cats_path
    else
      redirect_to admin_login_path
    end
    # this will log the user in if their credentials match, then go from there

    # has secure password gives us an instance method .authenticate to call on user with the user's password
  end


  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end