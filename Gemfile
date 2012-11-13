source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem "railties", "~> 3.2.8"
gem 'bootstrap-sass','2.1.1'
gem 'bcrypt-ruby','3.0.1'
gem 'faker', '1.1.2'
gem 'rdiscount'
gem 'kaminari'
gem 'jquery-rails', '2.1.3'
gem 'twitter'
gem 'whenever', :require => false
gem 'haml'

group :development, :test do
  gem 'sqlite3','1.3.6'
  gem 'rspec-rails','2.11.4'
  gem 'guard-rspec','2.1.1'
  gem 'annotate','2.5.0'
  gem 'factory_girl_rails', '4.1.0'
  gem 'tapp'
  gem 'pry-rails'
end

group :production do
  gem 'mysql2'
  gem 'google-analytics-rails'
  gem 'newrelic_rpm'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end

group :test do
  gem 'simplecov', require: false
  gem 'launchy'
  gem 'capybara', git: 'git://github.com/jnicklas/capybara.git'
  gem 'growl','1.0.3'
  gem 'rb-fsevent',
   :git => 'git://github.com/ttilley/rb-fsevent.git',
   :branch => 'pre-compiled-gem-one-off',
   :require => false
  gem 'guard-spork','1.2.3'
  gem 'spork','~> 1.0rc'
  gem "timecop"
end
