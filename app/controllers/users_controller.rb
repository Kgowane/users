class UsersController < ApplicationController

  def index
    @users = User.all

  end

  def show
    @user = User.find(params[:id])
    @seller_transactions = ProductTransaction.where(seller_id: current_user)
    @buyer_transactions = ProductTransaction.where(buyer_id: current_user)
  end
end
