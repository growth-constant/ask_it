# frozen_string_literal: true

# app/models/ask_it/questions_type.rb
class AskIt::QuestionType
  @@questions_types = { multiple_choice: 2, free_response: 9, multi_select: 1 }

  def self.questions_types
    @@questions_types
  end

  def self.questions_types_title
    titled = {}
    AskIt::QuestionType.questions_types.each { |k, v| titled[k.to_s.titleize] = v }
    titled
  end

  def self.questions_type_ids
    @@questions_types.values
  end

  def self.questions_type_keys
    @@questions_types.keys
  end

  @@questions_types.each do |key, val|
    define_singleton_method key.to_s do
      val
    end
  end
end
