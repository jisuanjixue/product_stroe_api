# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test '产品价格正确' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test '通过产品名称过滤' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test '通过产品名称过滤并排序' do
    assert_equal [products(:another_tv), products(:one)], Product.filter_by_title('tv').sort
  end

  test '价格大于200并排序' do
    assert_equal [products(:two), products(:one)], Product .above_or_equal_to_price(200).sort
  end

  test '价格小于200并排序' do
    assert_equal [products(:another_tv)], Product .below_or_equal_to_price(200).sort
  end

  test '排序产品' do
    products(:two).touch
    assert_equal [products(:another_tv), products(:one), products(:two)], Product.recent.to_a
  end
end
