# frozen_string_literal: true

# require 'app/models/ask_it/survey'
require_relative '../app/models/ask_it/survey'
require_relative '../app/models/ask_it/section'
require_relative '../app/models/ask_it/question_type'
require_relative '../app/models/ask_it/question'
require_relative '../app/models/ask_it/predefined_value'
require_relative '../app/models/ask_it/options_type'
require_relative '../app/models/ask_it/option'
require_relative '../app/models/ask_it/attempt'
require_relative '../app/models/ask_it/answer'
require_relative 'ask_it/active_record'
require_relative '../app/controllers/ask_it/surveys_controller'
require_relative '../app/controllers/ask_it/attempts_controller'

module AskIt
end

ActiveRecord::Base.include AskIt::ActiveRecord
