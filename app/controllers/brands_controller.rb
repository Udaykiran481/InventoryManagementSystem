class BrandsController < ApplicationController
    before_action :set_brand, only: [:show, :edit, :update, :destroy]
    before_action :require_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
    def index
      if params[:search].present?
        search_results = search_brands
        @brands = search_results.map do |result|
          if result.respond_to?(:records)
            result.records
          else
            Brand.find(result._id)
          end
        end
      else
        @brands = Brand.all
      end
    end
  
    def show
    end
  
    def new
      @brand = Brand.new
    end
  
    def create
      @brand = Brand.new(brand_params)
      if @brand.save
        flash[:success] = 'Brand was successfully created.'
        redirect_to brands_path  
      else
        flash[:alert] = 'Failed to create a brand'
        render 'new'
      end
    end
  
    def edit
    end
  
    def update
      if @brand.update(brand_params)
        flash[:success] = 'Brand was successfully updated.'
        redirect_to brands_path
      else
        flash[:alert] = 'Failed to update the form'
        render 'edit'
      end
    end
  
    def destroy
      @brand.destroy
      flash[:alert] = 'Brand was successfully destroyed.'
      redirect_to brands_url
    end
  
    private
  
    def set_brand
      @brand = Brand.find(params[:id])
    end
  
    def brand_params
      params.require(:brand).permit(:name)
    end

    def search_brands
      Brand.search(query: { match: { name: params[:search] } }).results
    end

    def require_admin
      unless current_user&.admin?
        flash[:alert] = 'You are not authorized to access this page.'
        redirect_to root_path
      end
    end
  end
  