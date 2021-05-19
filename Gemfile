# frozen_string_literal: true

source 'https://gems.ruby-china.com/'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use sqlite3 as the database for Active Record

gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'rspec-rails', '~> 3.5'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# group :production do
 
# end

# gem 'pg', '1.1.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'jwt', '~> 2.2'

gem 'faker', '~> 2.10'

# json api
gem 'fast_jsonapi', '~> 1.5'

# 分页
gem 'kaminari', '~> 1.2'

gem 'bullet', '~> 6.1', group: :development

# 跨域
gem 'rack-cors', '~> 1.1'

# rspec 测试文档生成
gem 'rswag'

gem 'rack-attack'

# 图片上传
gem 'carrierwave'
gem 'mini_magick'

# 用户权限
gem 'cancancan'
gem "rolify"

# 测试用户权限
gem 'graphiti'
# 实现按某年，某月，某日，或者星期几，来查询数据
gem 'by_star', git: "git://github.com/radar/by_star"

# 控制代码质量
gem "rails_best_practices"