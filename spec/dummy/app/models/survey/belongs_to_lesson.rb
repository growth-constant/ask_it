# frozen_string_literal: true

module AskIt
  module BelongsToLesson
    extend ActiveSupport::Concern
    included do
      belongs_to :lesson
    end
  end
end
