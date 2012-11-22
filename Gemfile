source 'https://rubygems.org'

# rails 4 edge
gem 'rails',     github: 'rails/rails'
gem 'journey',   github: 'rails/journey'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'faker'
gem 'rdiscount'
gem 'kaminari'
gem 'jquery-rails'
gem 'twitter'
gem 'whenever', require: false
gem 'haml'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

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

group :test do
  gem 'simplecov', require: false
  gem 'launchy'
  gem 'capybara', git: 'git://github.com/jnicklas/capybara.git'
  gem 'growl','1.0.3'
  gem 'rb-fsevent',
  git: 'git://github.com/ttilley/rb-fsevent.git',
  branch: 'pre-compiled-gem-one-off',
  require: false
  gem 'guard-spork','1.2.3'
  gem 'spork','~> 1.0rc'
  gem "timecop"
end

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'
