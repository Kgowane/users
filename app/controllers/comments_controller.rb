class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @user = current_user
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    # @comment = Comment.find(params[:id])
  end

  def new
    @user = current_user
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new
  end

  def edit
    user = current_user
    @product =Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    redirect_to products_path, alert: 'Access Denied' unless current_user == user
  end

  def create
    # @product = Product.find(params[:product_id])

    @user = current_user
    # @product = @user.products.find(params[:product_id])
    @comment = @user.comments.create(comment_params)
    if @comment.save
    redirect_to products_path
    else
      render 'new'
    end
  end

  def update

    product = Product.find(params[:product_id])
    user = product.user
    @comment = Comment.find(params[:id])

    if current_user != user
      redirect_to products_path, alert: 'Access Denied' unless current_user == user
    else
      if @comment.update(comment_params)
        redirect_to products_path
      else
        render 'edit'
      end
    end

  end

  def destroy
    @user = current_user
    @product = @user.products.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    @comment.destroy
    redirect_to product_path(@product)
  end

private
  def comment_params
    params.require(:comment)
          .permit(:comment, :user_id)
          .merge(product_id: params[:product_id])
  end
end
