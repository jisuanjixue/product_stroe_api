require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = orders(:one)
  end

  test "订单邮件发送成功" do
    mail = OrderMailer.send_confirmation(@order)
    assert_equal "订单信息", mail.subject
    assert_equal [@order.user.email], mail.to
    assert_equal ["from@example.com"], mail.from
    # assert_match "订单: ##{@order.id}", mail.body.encoded
    # assert_match "你已成功订购 #{@order.products.count} 产品", mail.body.encoded
  end

end
