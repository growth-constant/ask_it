# frozen_string_literal: true

module AskIt
  class Survey < ActiveRecord::Base
    self.table_name = 'survey_surveys'

    # relations
    has_many :attempts, class_name: 'AskIt::Attempt'
    has_many :sections, class_name: 'AskIt::Section'
    has_many :questions, through: :sections, class_name: 'AskIt::Question'

    # rails 3 attr_accessible support
    if Rails::VERSION::MAJOR < 4
      attr_accessible :name, :description, :finished, :active, :sections_attributes, :attempts_number, :locale_name,
                      :locale_description
    end

    accepts_nested_attributes_for :sections,
                                  reject_if: ->(q) { q[:name].blank? }, allow_destroy: true

    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }

    validates :attempts_number,
              numericality: { only_integer: true, greater_than: -1 }

    # validations
    validates :description, :name, presence: true, allow_blank: false
    validate  :check_active_requirements

    # returns all the correct options for current surveys
    def correct_options
      AskIt::Question.where(section_id: section_ids).map(&:correct_options).flatten
    end

    # returns all the incorrect options for current surveys
    def incorrect_options
      AskIt::Question.where(section_id: sections.collect(&:id)).map(&:incorrect_options).flatten
    end

    def avaliable_for_participant?(participant)
      current_number_of_attempts =
        attempts.for_participant(participant).size
      upper_bound = attempts_number
      !(current_number_of_attempts >= upper_bound && upper_bound != 0)
    end

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

    #######

    private

    #######

    # a surveys only can be activated if has one or more sections and questions
    def check_active_requirements
      return unless sections.empty? || sections.collect(&:questions).empty?

      errors.add(:base, 'Survey without sections or questions cannot be saved')
    end
  end
end
