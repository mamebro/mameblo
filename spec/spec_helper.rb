ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'
require 'json_expressions/rspec'

Dir[Rails.root.join("spec/support/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Capybara::DSL
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end
end
