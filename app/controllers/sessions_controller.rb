class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to products_path
    else
      flash[:login_errors] = ["Invalid email or password"]
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private
  def login_params
    params.require(:sessions).permit(:email, :password)
  end
end
