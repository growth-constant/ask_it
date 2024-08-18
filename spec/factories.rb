# frozen_string_literal: trueFactoryBot.define do
FactoryBot.define do
  factory :survey, class:'AskIt::Survey' do
    name { Faker::Name.name }
    attempts_number { 3 }
    description { Faker::Lorem.paragraph(1) }
  end

  factory :section, class:'AskIt::Section' do
    head_number { Faker::Name.name }
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph(1) }
  end

  factory :question, class:'AskIt::Question' do
    text { Faker::Lorem.paragraph(1) }
    options_attributes { { option: correct_option_attributes } }
    questions_type_id { AskIt::QuestionsType.multiple_choice }
    mandatory { false }
  end

  factory :predefined_value, class:'AskIt::PredefinedValue' do
    name { Faker::Name.name }
  end

  factory :option, class:'AskIt::Option' do
    text { Faker::Lorem.paragraph(1) }
    options_type_id { AskIt::OptionsType.multi_choices }
    correct { false }
  end

  factory :correct_option, class:'AskIt::Option' do
    correct { true }
  end

  factory :user do
    name { Faker::Name.name }
  end

  factory :lesson do
    name { Faker::Company.catch_phrase }
  end # Helper methods

  def create_survey_with_sections(num, sections_num = 1)
    survey = create(:survey)
    sections_num.times do
      section = create(:section)
      num.times do
        question = create(:question)
        num.times { create(:correct_option, question: question) }
        section.questions << question
      end
      survey.sections << section
    end
    survey.save
    survey
  end
end

def create_attempt_for(user, survey, opts = {})
  correct_options = opts.fetch(:all, :wrong) == :right ? survey.correct_options : survey.correct_options[1..-1]
  create(:attempt, user: user, survey: survey, options: correct_options)
  enddefcreate_answer(opts = {})
  survey = create_survey_with_sections(1)
  section = survey.sections.first
  question = section.questions.first
  option = question.options.first
  attempt = create(:attempt, user: create(:user), survey: survey)
  AskIt::Answer.create({ option: option, attempt: attempt, question: question }.merge(opts))
end