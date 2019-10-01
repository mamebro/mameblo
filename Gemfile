source 'https://rubygems.org'
ruby '2.6.3'

# ref: https://github.com/rails/rails/commit/12d5c21031446686898d5bac924ff3e9e34b6a7d
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'bootstrap-sass'
gem 'bcrypt-ruby'
gem 'faker'
gem 'redcarpet'
gem 'kaminari'
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
gem 'yaml_db'
gem 'rb-readline'

gem 'resource_name_validator'

gem 'rack-cors', :require => 'rack/cors'
gem 'pg'

gem 'puma'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem "rspec-support"
  gem 'rspec'
  gem "rspec-core"
  gem "rspec-expectations"
  gem "rspec-mocks"
  gem 'guard-rspec'
  gem 'annotate'
  gem 'factory_bot_rails'
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
