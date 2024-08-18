# frozen_string_literal: true

class AskIt::Answer < ActiveRecord::Base
  self.table_name = 'survey_answers'
  belongs_to :attempt
  belongs_to :option
  belongs_to :predefined_value
  belongs_to :question

  validates :option_id, :question_id, presence: true
  validates :predefined_value_id, presence: true, if: proc { |a| a.question && a.question.mandatory? && a.question.predefined_values.count > 0 && ![AskIt::OptionsType.text, AskIt::OptionsType.large_text].include?(a.option.options_type_id) }
  validates :option_text, presence: true, if: proc { |a| a.option && (a.question && a.question.mandatory? && a.question.predefined_values.count == 0 && [AskIt::OptionsType.text, AskIt::OptionsType.multi_choices_with_text, AskIt::OptionsType.single_choice_with_text, AskIt::OptionsType.large_text].include?(a.option.options_type_id)) }
  validates :option_number, presence: true, if: proc { |a| a.option && (a.question && a.question.mandatory? && [AskIt::OptionsType.number, AskIt::OptionsType.multi_choices_with_number, AskIt::OptionsType.single_choice_with_number].include?(a.option.options_type_id)) }

  # rails 3 attr_accessible support
  if Rails::VERSION::MAJOR < 4
    attr_accessible :option, :attempt, :question, :question_id, :option_id, :predefined_value_id, :attempt_id, :option_text, :option_number
  end

  before_create :characterize_answer
  before_save :check_single_choice_with_field_case

  def value
    if option.nil?
      AskIt::Option.find(option_id).weight
    else
      option.weight
    end
  end

  def correct?
    correct || option.correct?
  end

  #######

  private

  #######

  def characterize_answer
    self.correct = true if option.correct?
  end

  def check_single_choice_with_field_case
    if [AskIt::OptionsType.multi_choices, AskIt::OptionsType.single_choice].include?(option.options_type_id)
      self.option_text = nil
      self.option_number = nil
    end
  end
end
