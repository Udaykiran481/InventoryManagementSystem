class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    if params[:search].present?
      search_results = search_categories
      @categories = search_results.map do |result|
        if result.respond_to?(:records)
          result.records
        else
          Category.find(result._id)
        end
      end
    else
      @categories = Category.all
    end
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was successfully created.'
      redirect_to categories_path
    else
      flash[:alert] = 'Failed to create the category. Please check the form.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category was successfully updated.'
      redirect_to categories_path
    else
      flash[:alert] = 'Failed to update the category. Please check the form.'
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category was successfully destroyed.'
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :quantity, :buffer_quantity)
  end

  def search_categories
    Category.search(query: { match: { name: params[:search] } }).results
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to access this page.'
      redirect_to root_path
    end
  end
end
