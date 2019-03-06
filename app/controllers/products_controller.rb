class ProductsController < ApplicationController
  def index
    @user = current_user
    @products = Product.all
    @product_pages = Product.order(:name).page params[:page]
  end

  def show
    @product = Product.find(params[:id])
    @product_transactions = ProductTransaction.where(product_id: @product.id)
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    user = @product.user
    redirect_to products_path, alert: 'Access Denied' unless current_user == user
  end

  def create
    product = current_user.products.create! product_params

    product.image.attach(params[:product][:image])
    redirect_to user_session_path
  end

  def update
    @user = current_user
    @product = @user.products.find(params[:id])
    if @product.update(product_params)
      redirect_to user_session_path
    else
      render 'edit'
    end
  end

  def buy_product
    @product = Product.find(params[:id])
    @product.quantity -= 1 unless @product.quantity == 0
    @product.save

    @product_transaction = ProductTransaction.new(product_id: @product.id, seller_id: @product.user.id, buyer_id: current_user.id, price: @product.price)

    if @product_transaction.save
      redirect_to products_path, alert: "Purchase Successful: #{@product.name}"
    else
      render 'show'
    end
  end

  def destroy
    #user = current_user
    @product = Product.find(params[:id])

    user = @product.user
    if current_user != user
      redirect_to products_path, alert: 'Access Denied'
    else
      @product.destroy
    end
  end

private
  def product_params
      params.require(:product).permit(:name, :price, :quantity, :image)
  end


end
