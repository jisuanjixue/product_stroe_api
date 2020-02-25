require 'test_helper'

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "显示产品" do
    get api_v1_product_url(@product), as: :json
    assert_response :success

    json_response = JSON.parse(self.response.body)
    assert_equal @product.title, json_response['data']['attributes']['title']
  end

  test '显示产品列表' do
    get api_v1_products_url(), as: :json
    assert_response :success
  end

  test '创建产品' do
    assert_difference("Product.count") do
      post api_v1_products_url, params: {product: {title: @product.title, price: @product.price, published: @product.published}},
      headers: {Authorization: JsonWebToken.encode(user_id: @product.user_id)},
      as: :json
    end
    assert_response :created
  end

  test '没有登录不能创建产品' do
    assert_no_difference("Product.count") do
      post api_v1_products_url, params: {product: {title: @product.title, price: @product.price, published: @product.published}},
      as: :json
    end
    assert_response :forbidden
  end

  test '修改产品' do
    patch api_v1_product_url(@product), params: {product: {title: @product.title}},
      headers: {Authorization: JsonWebToken.encode(user_id: @product.user_id)},
      as: :json
    assert_response :success
  end

  test '其他人不能修改自己的产品' do
      patch api_v1_product_url(@product), params: {product: {title: @product.title}},
      headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
      as: :json
    assert_response :forbidden
  end

  test '删除产品' do
    assert_difference("Product.count", -1) do
    delete api_v1_product_url(@product),
      headers: {Authorization: JsonWebToken.encode(user_id: @product.user_id)},
      as: :json
      end
    assert_response :no_content
  end

  test '其他人不能删除自己的产品' do
    assert_no_difference("Product.count", -1) do
      delete api_v1_product_url(@product),
      headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
      as: :json
    end

    assert_response :forbidden
  end

  test '分页测试' do
    get api_v1_products_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body, symbolize_names: true)
    
    assert_json_response_is_paginated json_response
  end

end
