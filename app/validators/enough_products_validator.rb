class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        record.errors[product.title.to_s] << "不能再订购了，#{product.quantity}已到上限"
      end
    end
  end
end