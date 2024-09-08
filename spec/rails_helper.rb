# frozen_string_literal: true

# frozen_string_literal: trueENV['RAILS_ENV'] ||= 'test'requireFile.expand_path('../dummy/config/environment', __FILE__)
# require 'rspec/rails'

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  enable_coverage :branch
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/spec/'
end

def transform_gemfile_path(path)
  # check if path does not have a rails_7.1.0 pattern
  # and throw an error if it does not
  raise "Path does not have a rails_7.1.0 pattern: #{path}" unless path.match(/rails_(\d+)\.(\d+)\.0/)

  match = path.match(/rails_(\d+)\.(\d+)\.0/)
  "dummy_#{match[1]}#{match[2]}0"
end

env_path = "#{transform_gemfile_path(ENV.fetch('BUNDLE_GEMFILE'))}/config/environment"
puts "env_path: #{env_path}"
require_relative env_path

# Eager load all Rails application classes
require_relative '../app/models/ask_it/question_type'
require_relative '../app/models/ask_it/question'

# puts Rails.application.config.autoload_paths
# puts Rails.application.config.autoload_paths

require 'faker'
require 'factory_bot'
require 'pry'
require 'rspec/rails'
require 'support/models_create'
require 'support/scores_and_attempts'

# Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

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
  config.include Support::ModelsCreate
  config.include Support::ScoresAndAttempts
  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
