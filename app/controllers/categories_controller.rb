class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end
  
  def new 
    @category = Category.new
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  private
  
  def category_param
    params[:category][:name] ||= []
    params.permit(:category).permit(:category, name: [])
  end
end 