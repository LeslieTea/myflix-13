class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Your account has been created."
      session[:user_id] = @user.id
      AppMailer.send_welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      flash[:danger] = "Something went wrong."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      render :new
    else
      redirect_to expired_token_path
    end
  end

  
  def user_params
    params.require(:user).permit(:full_name, :password, :email)
  end


  

  
end