ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/vendor/'
end

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'json_expressions/rspec'

Dir[Rails.root.join("spec/support/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Capybara::DSL
  config.fixture_paths = ["#{::Rails.root}/spec/fixtures"]
  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  # Skip feature specs
  config.filter_run_excluding type: :feature

  config.include FactoryBot::Syntax::Methods
end
