class Product < ApplicationRecord
  has_one_attached :image 
  belongs_to :user
  has_many :product_transactions
  has_many :comments, dependent: :destroy
  paginates_per 5
end
