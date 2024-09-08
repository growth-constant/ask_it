# frozen_string_literal: true

# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'

require 'rails/test'
require 'faker'
require 'pry'

require File.expand_path('dummy_7/config/environment.rb', __dir__)

Rails.backtrace_cleaner.remove_silencers!

# Run any available migration
ActiveRecord::MigrationContext.new(File.expand_path('dummy/db/migrate', __dir__))

# Load support files
# Add support to load paths so we can overwrite broken webrat setup
$LOAD_PATH.unshift File.expand_path('support', __dir__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end
