# frozen_string_literal: true

class AskIt::PredefinedValue < ActiveRecord::Base
  self.table_name = 'survey_predefined_values'

  # relations
  belongs_to :question

  # rails 3 attr_accessible support
  if Rails::VERSION::MAJOR < 4
    attr_accessible :head_number, :name, :locale_name, :question_id
  end

  # validations
  validates :name, presence: true

  def to_s
    name
  end

  def name
    I18n.locale == I18n.default_locale ? super : locale_name || super
  end
end
