class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  validates :password_digest, presence: true
  validates_format_of :email, with: /@/, message: "无效的邮箱"
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
end
