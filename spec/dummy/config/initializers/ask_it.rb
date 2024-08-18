# frozen_string_literal: true

Rails.application.reloader.to_prepare do
  AskIt::Survey.include Survey::BelongsToLesson
end
