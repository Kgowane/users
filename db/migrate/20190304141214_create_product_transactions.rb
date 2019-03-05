class CreateProductTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :product_transactions do |t|
      t.references :product, foreign_key: true
      t.references :seller, index: true, foreign_key: {to_table: :users}
      t.references :buyer, index: true, foreign_key: {to_table: :users}
      t.integer :price

      t.timestamps
    end
  end
end
