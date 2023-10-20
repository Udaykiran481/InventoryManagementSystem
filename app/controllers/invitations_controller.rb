class InvitationsController < ApplicationController
  before_action :require_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.invitation_token = generate_invitation_token
    if @invitation.save
      send_invitation_email(@invitation)
      redirect_to employees_path, notice: 'Invitation sent successfully!'
    else
      render :new
    end
  end


  def accept
    reset_session
    @invitation = Invitation.find_by(invitation_token: params[:invitation_token])
    if @invitation
      @user = User.new(name:@invitation.name,email: @invitation.email) # Assuming you're using email for registration
      render new_user_path # Render the new user registration form
    else
      redirect_to root_path, alert: 'Invalid invitation token'
    end
  end

  def update
    # Handle the form submission when users complete their registration.
    # Create a User model with a password at this point.
    @user = User.new(user_params)
    if @user.save
      # Registration is successful, handle any additional logic.
      redirect_to root_path, notice: 'Registration completed successfully!'
    else
      render :new_user
    end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:name, :email)
  end

  def generate_invitation_token
    SecureRandom.urlsafe_base64
  end

  def send_invitation_email(invitation)
    UserMailer.invitation_email(invitation).deliver_now
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = 'You are not authorized to access this page.'
      redirect_to root_path
    end
  end
end
