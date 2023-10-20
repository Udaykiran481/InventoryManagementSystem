class StorageItemsController < ApplicationController
  def index
    @categories = Category.all
    @selected_category_id = params[:category_id]
    

    @selected_category_buffer_quantity = Category.find_by(id: @selected_category_id)&.buffer_quantity
    
    if @selected_category_id.present? && !@selected_category_id.empty?
      @items = Item.where(category_id: @selected_category_id)
      @storage_data = StorageItem.find_by(category_id: @selected_category_id)
      @selected_category = Category.find(@selected_category_id)
    else
      @items = Item.all
      @storage_data = nil 
    end
  end
  
end


