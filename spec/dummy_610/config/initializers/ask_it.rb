# frozen_string_literal: true

require_relative '../../app/models/ask_it/belongs_to_lesson'

AskIt::Survey.include AskIt::BelongsToLesson
