source 'https://rubygems.org'

# rails 4
gem 'rails', '4.0.0'
gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'faker'
gem 'redcarpet'
gem 'kaminari'
gem 'jquery-rails'
gem 'twitter'
gem 'whenever', require: false
gem 'haml'
gem 'faraday'
gem 'lazy_high_charts'
gem 'newrelic_rpm'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails'
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby
  gem 'execjs'
  gem 'therubyracer'
  gem 'uglifier'
end

group :production do
  gem 'mysql2'
  gem 'google-analytics-rails'
end

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "rspec"
  gem "rspec-core"
  gem "rspec-expectations"
  gem "rspec-mocks"
  gem 'guard-rspec'
  gem 'annotate'
  gem 'factory_girl_rails'
  gem 'tapp'
  gem 'pry-rails'
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'growl'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'spork'
  gem "timecop"
end
