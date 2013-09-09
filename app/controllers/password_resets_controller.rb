class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    @user.send_password_reset if @user
    redirect_to login_path, notice: 'Email sent with instructions for resetting password'
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Permission to change password has expired."
    elsif @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Password reset."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
