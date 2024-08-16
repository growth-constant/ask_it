# frozen_string_literal: true

RailsAdmin.config do |c|
  c.excluded_models = [
    AskIt::Answer,
    AskIt::Option,
    AskIt::Attempt,
    AskIt::Question
  ]
end
