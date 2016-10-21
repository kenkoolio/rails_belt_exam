class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to products_path
    else
      flash[:registration_errors] = @user.errors.full_messages
      redirect_to new_session_path
    end
  end

  private
  def user_params
    params.require(:users).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
