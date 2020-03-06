# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Product.delete_all

Role.create(name: 'admin')
Role.create(name: 'normal_user')

admin_user = User.create! email: Faker::Internet.email, password: 'admin1234', avatar: Faker::Avatar.image(slug: "admin-avatar", size: "50x50")
puts "创建admin新用户: #{admin_user.email}"

admin_user.add_role(:admin)

5.times do
  user = User.create! email: Faker::Internet.email, password: 'locadex1234', avatar: Faker::Avatar.image(slug: "my-avatar", size: "50x50")
  puts "创建新用户: #{user.email}"

  user.add_role(:normal_user)

  2.times do
    product = Product.create!(
      title: Faker::Commerce.product_name,
      price: rand(1.0..100.0),
      published: true,
      product_logo: Faker::Avatar.image,
      user_id: user.id
    )
    puts "创建新产品: #{product.title}"
  end
end
