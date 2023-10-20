class EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    if params[:search].present?
      search_results = search_employees
      @employees = search_results.map do |result|
        if result.respond_to?(:records)
          result.records
        else
          Employee.find(result._id)
        end
      end
    else
      @employees = Employee.all
    end
  end


  def show
    @allocated_items = Item.where(employee_id: @employee.user_id)
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      flash[:success] = "Employee updated successfully."
      redirect_to employees_path
    else
      render 'edit'
    end
  end

  def destroy
    if @employee.destroy
      flash[:success] = "Employee deleted successfully."
    else
      flash[:error] = "Failed to delete employee."
    end
    redirect_to employees_path
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :status)
  end

  def find_employee
    @employee = Employee.find(params[:id])
  end

  def search_employees
    Employee.search(query: { match: { name: params[:search] } }).results
  end
  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to access this page.'
      redirect_to root_path
    end
  end
end
