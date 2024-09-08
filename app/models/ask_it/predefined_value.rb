# frozen_string_literal: true

module AskIt
  class PredefinedValue < ActiveRecord::Base
    self.table_name = 'survey_predefined_values'

    # relations
    belongs_to :question

    # rails 3 attr_accessible support
    attr_accessible :head_number, :name, :locale_name, :question_id if Rails::VERSION::MAJOR < 4

    # validations
    validates :name, presence: true

    def to_s
      name
    end

    def name
      I18n.locale == I18n.default_locale ? super : locale_name || super
    end
  end
end
