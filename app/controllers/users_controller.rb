class UsersController < ApplicationController

  def profile
  end

  def edit_profile
  end

  def update_profile
    if @current_user.update(user_params)
      redirect_to edit_profile_path, notice: "Profile information updated."
    else
      render :edit_profile
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
