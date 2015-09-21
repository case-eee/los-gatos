class Admin::CatsController < ApplicationController

  before_filter :require_login

  def index
    # this method will welcome a user after they've signed it
    # it will show a list of all the cats in a random order
    @cats = Cat.all
  end

  def new
    # this will render a form to create a new cat
  end

  def create
    # this will do the creation of a new cat
  end

  def destroy
    # delete that cat
  end

  def edit
    # this will render the edit form
  end

  def update
    # this will do the actual updating, find the cat then update it
  end


  private

  def cat_params

  end

  def require_login
    redirect_to admin_login_path unless session[:user_id]
  end

end