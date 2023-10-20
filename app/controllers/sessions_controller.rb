class SessionsController < ApplicationController
    def index
    end
    
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email])
      if user.present? && user.authenticate(params[:session][:password])
        log_in user
        flash[:success] = 'Logged in successfully!'
        redirect_to users_path
      else
        flash[:alert] = 'Invalid email/password combination'
        render 'new'
      end
    end
  
    def destroy
      log_out
      flash[:alert] = 'Logged out successfully!'
      redirect_to new_user_path
    end

    def omniauth
      user = User.find_or_create_by(uid:request.env['omniauth.auth'][:uid] , provider:request.env['omniauth.auth'][:provider] ) do |u|
        u.name=request.env['omniauth.auth'][:info][:first_name]
        u.email=request.env['omniauth.auth'][:info][:email]
        u.password_digest=SecureRandom.hex(15)
      end
      if user.valid?
        session[:user_id]=user.id
        flash[:success] = 'Logged in successfully!'
        redirect_to users_path
      else
        flash[:alert]= 'Log in failed!'
        redirect_to login_path
      end
    end
  end





  