class OrderMailer < ApplicationMailer
  default from: 'from@example.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.send_confirmation.subject
  #
  def send_confirmation(order)
    @order = order
    @user = @order.user
    mail to: @user.email, subject: '订单信息'
  end
end
