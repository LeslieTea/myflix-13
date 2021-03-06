class ForgotPasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      AppMailer.send_forgot_password(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = params[:email].blank? ? "Email cannot be blank" : "There is no user with that email in this system."
      redirect_to forgot_password_path
  end
  end
end