require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do
    @order = orders(:one)
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test '订单总价' do
    order = Order.new user_id: @order.user_id
    order.products << products(:one)
    order.products << products(:two)
    order.save
    assert_equal (@product1.price + @product2.price), order.total
  end

  test '新建2个placements 为订单' do
    @order.build_placements_with_product_ids_and_quantities [
    { product_id: @product1.id, quantity: 2 },
    { product_id: @product2.id, quantity: 3 }]

    assert_difference('Placement.count', 2) do
      @order.save
    end
  end

  test "已达到产品数量，不能再添加产品了" do
    @order.placements << Placement.new(product_id: @product1 .id, quantity: (1 + @product1.quantity))
    assert_not @order.valid?
  end

end
