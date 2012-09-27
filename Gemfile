source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem "railties", "~> 3.2.8"
gem 'bootstrap-sass','2.0.0'
gem 'bcrypt-ruby','3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'rdiscount'
gem 'kaminari'
gem 'jquery-rails', '2.0.2'
gem 'twitter'
gem 'whenever', :require => false

group :development, :test do
  gem 'sqlite3','1.3.5'
  gem 'rspec-rails','2.11.0'
  gem 'guard-rspec','0.5.5'
  gem 'annotate','~>2.4.1.beta'
  gem 'factory_girl_rails','3.3.0'
  gem 'tapp'
end

group :production do
  gem 'mysql2'
  gem 'google-analytics-rails'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end

group :test do
  gem 'launchy'
  gem 'capybara','1.1.2'
  gem 'growl','1.0.3'
  gem 'rb-fsevent',
   :git => 'git://github.com/ttilley/rb-fsevent.git',
   :branch => 'pre-compiled-gem-one-off',
   :require => false
  gem 'guard-spork','0.3.2'
  gem 'spork','~> 1.0rc'
end