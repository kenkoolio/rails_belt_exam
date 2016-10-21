class ProductsController < ApplicationController
  before_action :get_user, only: [:index]
  before_action :get_all_products, only: [:index]

  def index
  end

  def create
    @product = User.find(session[:user_id]).own_products.new(new_product_params)
    if @product.save
      redirect_to user_path(session[:user_id])
    else
      flash[:errors] = @product.errors.full_messages
      redirect_to user_path(session[:user_id])
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product
      @product.update(productable: User.find(session[:user_id]))
    end
    redirect_to user_path(session[:user_id])
  end

  def destroy
    @product = Product.find(params[:id])
    if @product && @product.user == current_user
      @product.destroy
      redirect_to user_path(session[:user_id])
    else
      flash[:errors] = ["OOPS! something went wrong, don't h@k me bru"]
      redirect_to user_path(session[:user_id])
    end
  end


  private
  def get_user
    @user = User.find(session[:user_id])
  end

  def get_all_products
    @products = Product.where(productable_id: nil)
  end

  def new_product_params
    params.require(:product).permit(:name, :amount)
  end
end
