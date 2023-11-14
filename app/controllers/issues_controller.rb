class IssuesController < ApplicationController
    before_action :set_employee_items, only: [:new, :create]
    before_action :require_login
  
    def index
      @issue = Issue.new
      if current_user.role == 'admin'
        @employees = User.where(role: 'employee')
        if params[:employee_id].present?
          @selected_employee = User.find(params[:employee_id])
          @employee_items = @selected_employee.items.includes(:issue)
        else
          @employee_items = Item.includes(:issue)
        end
      else 
        @employee_items = current_user.items.all
      end
    end
  
    def new
      @issue = Issue.new
    end
  
    def create
      @issue = Issue.new(issue_params)
      @issue.user_id=current_user.id
      if @issue.save
        admin_users = User.admin
        item = Item.find_by(id: @issue.item_id)
        admin_users.each do |admin|
          admin.notifications.create(
            message: "New issue reported by #{current_user.name} (#{current_user.email}) for item: #{item.name}",
            category_id: item.category_id,
            item_id: @issue.item_id,
            issue_id: @issue.id
          )
        end
        flash[:success] = 'Issue was successfully reported.'
        redirect_to issues_path
      else
        render 'new'
      end
    end

    def edit
      @issue = Issue.find(params[:id])
    end

    def update
      @issue = Issue.find(params[:id])
      if @issue.update(issue_params)
        user = User.find_by(id: @issue.user_id)
        item = Item.find_by(id: @issue.item_id)
        puts user.name
        if user.id
          message = "Your issue for item: #{item.name} has been resolved."
          user.notifications.create(
            message: message,
            category_id: item.category_id,
            item_id: @issue.item_id,
            issue_id: @issue.id
          )
          @resolved_at = Time.now
          EmployeeMailer.issue_resolved_email(user, item, @issue,@resolved_at).deliver_now
        end
        flash[:success] = 'Issue has been resolved.'
        redirect_to issues_path
      else
        flash[:alert] = 'Failed to resolve issue.'
        render 'edit'
      end
    end

    
    private
  
    def issue_params
      params.require(:issue).permit(:description, :resolved, :item_id , :user_id)
    end
  
    def set_employee_items
      @employee_items = current_user.items.all
    end

    def require_login
      unless !current_user.nil?
        flash[:alert] = 'Please log in to access this page.'
        redirect_to login_path
      end
    end
  end
  