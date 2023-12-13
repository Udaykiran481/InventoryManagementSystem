class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :require_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  
    def index
      if params[:search].present?
        search_results = search_items
        @items = search_results.map do |result|
          if result.respond_to?(:records)
            result.records
          else
            Item.find(result._id)
          end
        end
      else
        @items = Item.all
      end
    end
  
    def show
    end
  
    def new
      @item = Item.new
      @employees = User.where(role: 'employee')
    end
  
    def create
      @employees = User.where(role: 'employee')
      @item = Item.new(item_params)
      if @item.save
        if @item.employee_id?
          category = @item.category
          category.update_buffer_quantity(1) if category
          category.check_and_send_notifications(@item) if category
        end
        flash[:success] = "Item created successfully."
        redirect_to items_path, notice: 'Item was successfully created.'
      else
        flash[:error] = "Failed to create an Item."
        render 'new'
      end
    end 

    
    def edit
      @employees = User.where(role: 'employee')
    end

    def update
      @employees = User.where(role: 'employee')
      employee_id = params[:item][:employee_id].to_i 
      if employee_id != @item.employee_id.to_i
        if @item.update(employee_id: employee_id)
          category = @item.category
          category.update_buffer_quantity(1) if category
          category.check_and_send_notifications(@item) if category
          redirect_to items_path
          flash[:success] = 'Item was successfully allocated to the employee.'
        else
          flash[:error] = 'Failed to allocate item.'
        end
      else
        # Only update the item attributes (not the employee)
        if @item.update(item_params.except(:employee_id))
          redirect_to items_path
          flash[:success] = 'Item was successfully updated.'
        else
          render 'edit'
        end
      end
    end
    
    def destroy
      if @item.employee.present?
        flash[:alert] = 'Cannot delete item with an associated employee.'
        redirect_to items_path
      else
        @item.destroy
        flash[:alert] = ' Deleted an item sucessfully!.'
        redirect_to items_path
      end
    end
   

    def reallocate
      @item = Item.find(params[:id])
      @employees = User.where(role: 'employee')
    end
  
    def perform_reallocate
      @item = Item.find(params[:id])
      if @item.update(item_params)
        flash[:success] = 'Item successfully reallocated.'
        redirect_to items_path
      else
        flash[:error] = 'Failed to reallocate item.'
        render 'reallocate'
      end
    end
  
    def deallocate
      @item = Item.find(params[:id])
      if @item.update(employee_id: nil)
        category = @item.category
        category.update_buffer(1) if category
        flash[:success] = 'Item successfully deallocated.'
        redirect_to items_path
      else
        flash[:error] = 'Failed to deallocate item.'
        redirect_to item_path(@item)
      end
    end
    

    private
  
    def set_item
      @item = Item.find(params[:id])
    end
  
    def item_params
      params.require(:item).permit(:name, :brand_id, :category_id, :employee_id, :status, :notes, :item_document)
    end

    def search_items
      Item.search(query: { match: { name: params[:search] } }).results
    end

    def require_admin
      unless current_user&.admin?
        flash[:alert] = 'You are not authorized to access this page.'
        redirect_to root_path
      end
    end
  end
  
