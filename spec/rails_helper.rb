# frozen_string_literal: trueENV['RAILS_ENV'] ||= 'test'requireFile.expand_path('../dummy/config/environment', __FILE__)
#require 'rspec/rails'

ENV['RAILS_ENV'] ||= 'test'

require_relative './dummy_7/config/environment'

require 'ask_it'
require 'faker'
require 'factory_bot'
require 'rspec/rails'

#Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# Ensure that migrations are run before the test suite is executed
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.mock_with :mocha
  # setup factory bot
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end