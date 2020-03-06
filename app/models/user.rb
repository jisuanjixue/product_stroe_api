# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  mount_uploader :avatar, AvatarUploader
  has_secure_password
  validates :email, uniqueness: true
  validates :password_digest, presence: true
  validates_format_of :email, with: /@/, message: '无效的邮箱'
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  Roles = %i[admin default].freeze

  def admin?
    has_role?(:admin)
 end

  def normal_user?
    has_role?(:normal_user)
  end
end
