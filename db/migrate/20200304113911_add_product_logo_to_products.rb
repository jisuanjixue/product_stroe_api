class AddProductLogoToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_logo, :string
  end
end
