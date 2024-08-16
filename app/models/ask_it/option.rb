# frozen_string_literal: true

class AskIt::Option < ActiveRecord::Base
  self.table_name = 'survey_options'
  # relations
  belongs_to :question
  has_many :answers

  # rails 3 attr_accessible support
  if Rails::VERSION::MAJOR < 4
    attr_accessible :text, :correct, :weight, :question_id, :locale_text, :options_type_id, :head_number
  end

  # validations
  validates :text, presence: true, allow_blank: false, if: proc { |o| [AskIt::OptionsType.multi_choices, AskIt::OptionsType.single_choice, AskIt::OptionsType.single_choice_with_text, AskIt::OptionsType.single_choice_with_number, AskIt::OptionsType.multi_choices_with_text, AskIt::OptionsType.multi_choices_with_number, AskIt::OptionsType.large_text].include?(o.options_type_id) }
  validates :options_type_id, presence: true
  validates :options_type_id, inclusion: { in: AskIt::OptionsType.options_type_ids, unless: proc { |o| o.options_type_id.blank? } }

  scope :correct, -> { where(correct: true) }
  scope :incorrect, -> { where(correct: false) }

  before_create :default_option_weigth

  def to_s
    text
  end

  def correct?
    correct == true
  end

  def text
    I18n.locale == I18n.default_locale ? super : locale_text.blank? ? super : locale_text
  end

  #######

  private

  #######

  def default_option_weigth
    self.weight = 1 if correct && weight == 0
  end
end
