class Admin::CatsController < ApplicationController

  before_filter :require_login

  def index
    @cats = Cat.all
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to admin_cats_path
    else
      render :new
    end
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
    params.require(:cat).permit(:url, :description)
  end

  def require_login
    redirect_to admin_login_path unless session[:user_id]
  end

end