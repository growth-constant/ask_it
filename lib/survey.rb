# frozen_string_literal: true

require 'ask_it/engine'
require 'ask_it/version'
require 'ask_it/active_record'

ActiveRecord::Base.include AskIt::ActiveRecord
