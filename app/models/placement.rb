class Placement < ApplicationRecord
  belongs_to :product
  belongs_to :order, inverse_of: :placements

  after_create :decrement_product_quantity!

  def decrement_product_quantity!
    product.decrement!(:quantity, quantity)
  end
end
