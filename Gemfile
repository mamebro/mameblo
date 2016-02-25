source 'https://rubygems.org'

gem 'rails', '~> 5.0.0.beta3'
gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'faker'
gem 'redcarpet'
gem 'kaminari', github: 'amatsuda/kaminari', branch: 'master'
gem 'jquery-rails'
gem 'whenever', require: false
gem 'haml'
gem 'faraday'

# Rails5.0.0.beta1 support is none: https://discuss.newrelic.com/t/rails-5-0-support/26595/10
# gem 'newrelic_rpm'

gem 'github-markdown'
gem 'active_model_serializers'
gem 'sprockets'
gem 'sprockets-rails'
gem 'sass-rails'
gem 'responders'
gem 'coffee-rails'
gem 'compass-rails', github: 'Compass/compass-rails'
gem 'execjs'
gem 'therubyracer'
gem 'uglifier'
gem 'rack-google-analytics'
gem 'awesome_print'

group :production do
  gem 'mysql2', '~> 0.3.20'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem "rspec-support", git: "https://github.com/rspec/rspec-support.git", branch: "master"
  gem 'rspec', github: 'rspec/rspec'
  gem "rspec-core", git: "https://github.com/rspec/rspec-core.git", branch: "master"
  gem "rspec-expectations", git: "https://github.com/rspec/rspec-expectations.git", branch: "master"
  gem "rspec-mocks", git: "https://github.com/rspec/rspec-mocks.git", branch: "master"
  gem 'guard-rspec', github: 'guard/guard-rspec'
  gem 'annotate'
  gem 'factory_girl_rails'
  gem 'tapp'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'database_rewinder'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'launchy'
  gem 'capybara'
  gem 'growl'
  gem 'rb-fsevent'
  gem 'guard-spork'
  gem 'spork'
  gem 'timecop'
  gem 'json_expressions'
  gem 'autodoc'
end
