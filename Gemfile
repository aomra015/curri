source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
ruby "2.0.0"
gem 'rails', '>= 4.0.0'
gem 'pg'

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-rescue'
  gem "mocha", :require => false
  gem "teaspoon"
end

group :development do
  gem 'brakeman', :require => false
  gem 'better_errors'
  gem 'rails_best_practices'
  gem 'bullet'
  gem 'spring'
end

group :test do
  gem 'simplecov', :require => false
  gem 'minitest-rails-capybara'
  gem 'minitest-colorize'
end

gem 'email_validator'
gem 'bcrypt-ruby'
gem 'private_pub'
gem "thin", "~> 1.6.1"
gem 'foreman'
gem 'dynamic_form'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Assets
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pickadate-rails'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development