module ProductsHelper
  def find_product_name product_id
    Product.find(product_id).name
  end
end
