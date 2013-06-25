source 'https://rubygems.org'

# rails 4 edge
gem 'rails',     github: 'rails/rails'
gem 'journey',   github: 'rails/journey'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

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

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby
  gem 'execjs'
  gem 'therubyracer'

  gem 'uglifier'
end

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

group :development, :test do
  gem 'sqlite3'
  gem "rspec-rails",        :git => "git://github.com/rspec/rspec-rails.git"
  gem "rspec",              :git => "git://github.com/rspec/rspec.git"
  gem "rspec-core",         :git => "git://github.com/rspec/rspec-core.git"
  gem "rspec-expectations", :git => "git://github.com/rspec/rspec-expectations.git"
  gem "rspec-mocks",        :git => "git://github.com/rspec/rspec-mocks.git"

  gem 'guard-rspec'
  gem 'annotate'
  gem 'factory_girl_rails'
  gem 'tapp'
  gem 'pry-rails'
end

group :production do
  gem 'mysql2'
  gem 'google-analytics-rails'
end

group :test do
  gem 'simplecov', require: false
  gem 'launchy'
  gem 'capybara', git: 'git://github.com/jnicklas/capybara.git'
  gem 'growl'
  gem 'rb-fsevent',
  git: 'git://github.com/ttilley/rb-fsevent.git',
  branch: 'pre-compiled-gem-one-off',
  require: false
  gem 'guard-spork'
  gem 'spork'
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
