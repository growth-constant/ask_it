# frozen_string_literal: true

module AskIt
  class Section < ActiveRecord::Base
    self.table_name = 'survey_sections'

    # relations
    has_many :questions
    belongs_to :survey

    # rails 3 attr_accessible support
    if Rails::VERSION::MAJOR < 4
      attr_accessible :questions_attributes, :head_number, :name, :description, :survey_id, :locale_head_number,
                      :locale_name, :locale_description
    end

    accepts_nested_attributes_for :questions,
                                  reject_if: ->(q) { q[:text].blank? }, allow_destroy: true

    # validations
    validates :name, presence: true, allow_blank: false
    validate  :check_questions_requirements

    def name
      if I18n.locale == I18n.default_locale
        super
      else
        locale_name.blank? ? super : locale_name
      end
    end

    def description
      if I18n.locale == I18n.default_locale
        super
      else
        locale_description.blank? ? super : locale_description
      end
    end

    def head_number
      if I18n.locale == I18n.default_locale
        super
      else
        locale_head_number.blank? ? super : locale_head_number
      end
    end

    def full_name
      head_name = head_number.blank? ? '' : "#{head_number}: "
      "#{head_name}#{name}"
    end

    #######

    private

    #######

    # a section only can be saved if has one or more questions and options
    def check_questions_requirements
      return unless questions.empty? || questions.collect(&:options).empty?

      errors.add(:base, 'Section without questions or options cannot be saved')
    end
  end
end
