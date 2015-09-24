class Admin::CatsController < ApplicationController

  before_filter :require_login

  def index
    if params["sort"] == "amazing"
      @cats = Cat.sort_by_amazing
    elsif params["sort"] == "cute"
      @cats = Cat.sort_by_cute
    else
      @cats = Cat.all
    end

    respond_to do |format|
      format.html
      format.csv { send_data @cats.as_csv }
    end
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

  def show
    @cat = Cat.find_by(id: params[:id])
  end

  def destroy
    @cat = Cat.find_by(id: params[:id])
    @cat.destroy
    redirect_to admin_cats_path
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    @cat.update(cat_params)

    if @cat.valid?
      redirect_to admin_cats_path
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:url, :description)
  end

  def require_login
    redirect_to admin_login_path unless session[:user_id]
  end

end