# frozen_string_literal: trueENV['RAILS_ENV'] ||= 'test'requireFile.expand_path('../dummy/config/environment', __FILE__)
#require 'rspec/rails'
#require 'mocha/setup'
require 'faker'
require 'pry'

#Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

# ActiveRecord::Migration.maintain_test_schema!
