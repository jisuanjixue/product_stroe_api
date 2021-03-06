# frozen_string_literal: true

require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test '显示用户, 电子邮箱核对' do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @user.email, json_response['data'][ 'attributes']['email']
  end

  test '创建用户测试' do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json
    end
    assert_response :created
  end

  test '已有用户，创建用户失败' do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  test '更新用户成功' do
    patch api_v1_user_url(@user), 
    params: { user: { email: @user.email, password: '123456' } },
    headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
    as: :json
    assert_response :success
  end

  test '无效的邮箱修改用户失败' do
    patch api_v1_user_url(@user), 
    params: { user: { email: 'bad_email', password: '123456' } },
    headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
    as: :json
    assert_response :unprocessable_entity
  end

  test '删除用户成功' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), 
      headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
      as: :json
    end
    assert_response :no_content
  end

  test '只有自己登录后才可以修改自己' do
    patch api_v1_user_url(@user), 
    params: { user: { email: @user.email } },
    headers: { Authorization: JsonWebToken.encode(user_id: @user.id) },
    as: :json
    assert_response :success
  end

  test '没有登录不能修改自己' do
    patch api_v1_user_url(@user), params: { user: { email: @user.email } }, as: :json
    assert_response :forbidden
  end

  test '只有自己登录后才可以删除自己' do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), headers: { Authorization: JsonWebToken.encode(user_id: @user.id) }, as: :json
    end
    assert_response :no_content
  end

  test '没有登录不能删除用户' do
    assert_no_difference('User.count') do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :forbidden
  end
end
