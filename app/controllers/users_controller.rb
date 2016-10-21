class UsersController < ApplicationController
  before_action :get_user, only: [:show]
  before_action :sold_products, only: [:show]

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

  def show
  end

  private
  def user_params
    params.require(:users).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find(session[:user_id])
  end

  def sold_products
    @sold_products = User.find(session[:user_id]).own_products.where.not(productable_id: nil)
  end
end
