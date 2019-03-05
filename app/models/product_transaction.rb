class ProductTransaction < ApplicationRecord
  belongs_to :product
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'

  def date_helper
    created_at.strftime("%d %B %Y")
  end

end
