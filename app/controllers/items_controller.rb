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
      @item = Item.new(item_params)
      if @item.save
        if @item.employee_id?
          puts @item.employee_id
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
        # The employee is being changed, so update the buffer quantity
        if @item.update(employee_id: employee_id)
          category = @item.category
          category.update_buffer_quantity(1) if category
          category.check_and_send_notifications(@item) if category
          flash[:success] = 'Item was successfully allocated to the employee.'
        else
          flash[:error] = 'Failed to allocate item.'
        end
      else
        # Only update the item attributes (not the employee)
        if @item.update(item_params.except(:employee_id))
          flash[:success] = 'Item was successfully updated.'
        else
          flash[:alert] = 'Failed to update the item.'
        end
      end
    
      redirect_to items_path
    end
    
    def destroy
      if @item.employee.present?
        flash[:alert] = 'Cannot delete item with an associated employee.'
        redirect_to items_path
      else
        @item.destroy
        flash[:alert] = 'Cannot delete item with an associated employee.'
        redirect_to items_path
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
  
