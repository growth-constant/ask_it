# frozen_string_literal: trueENV['RAILS_ENV'] ||= 'test'requireFile.expand_path('../dummy/config/environment', __FILE__)
#require 'rspec/rails'

ENV['RAILS_ENV'] ||= 'test'

require 'faker'
require 'factory_bot'

require File.expand_path('./dummy/config/environment', __dir__)

#Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.mock_with :mocha
  # setup factory bot
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end