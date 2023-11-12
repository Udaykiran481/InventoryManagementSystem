class NotificationsController < ApplicationController
    def index
      @notifications = Notification.all.order(created_at: :desc)
      @user_notifications = Notification.where(user_id: current_user).order(created_at: :desc)
      current_user.notifications.update_all(read: true)
    end
  
    def show
      @notification = Notification.find(params[:id])
    end

end
  