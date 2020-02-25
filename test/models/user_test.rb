require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "有效的邮箱通过" do
    user = User.new(email: 'test@test.org',  password_digest: 'test')
    assert user.valid?
  end

  test '无效的邮箱不通过' do
    user = User.new(email: 'test',  password_digest: 'test')
    assert_not user.valid?
  end

  test '相同的邮箱不通过' do
    other_user = users(:one)
    user = User.new(email: other_user.email,  password_digest: 'test')
    assert_not user.valid?
  end

  test '删除用户也会删除其相关的产品' do
    assert_difference("Product.count", -1) do
      users(:one).destroy
    end
  end
end
