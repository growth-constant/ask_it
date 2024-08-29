# frozen_string_literal: trueFactoryBot.define do
FactoryBot.define do
  factory :survey, class:'AskIt::Survey' do
    name { Faker::Name.name }
    attempts { [] }
    attempts_number { attempts.size }
    sections { [] }
    active { true }
    description { Faker::Lorem.paragraph }
  end

  factory :section, class:'AskIt::Section' do
    head_number { Faker::Name.name }
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end

  factory :question, class:'AskIt::Question' do
    text { Faker::Lorem.paragraph }
    options { [create(:option)] }
    questions_type_id { AskIt::QuestionType.multiple_choice }
    mandatory { false }
  end

  factory :predefined_value, class:'AskIt::PredefinedValue' do
    name { Faker::Name.name }
  end

  factory :option, class:'AskIt::Option' do
    text { Faker::Lorem.paragraph }
    options_type_id { AskIt::OptionsType.multi_choices }
    correct { false }

    factory :correct_option do
      correct { true }
    end
  end

  factory :user do
    name { Faker::Name.name }
  end

  factory :lesson, class: 'Lesson' do
    name { Faker::Company.catch_phrase }
  end # Helper methods

  factory :attempt, class:'AskIt::Attempt' do
    survey
    participant { create(:user) }

    # create a transient attribute answers_array to pass to the factory
    transient do
      answers_array { [] }
    end

    # if the answers_array is passed, create answers from it
    # otherwise, create answers from the survey's questions
    after(:build) do |attempt, evaluator|
      if evaluator.answers_array.any?
        evaluator.answers_array.each do |answer|
          attempt.answers << answer 
        end
      else
        attempt.answers << attempt.survey.questions.map { |q| create(:answer, question: q) }
      end
    end
  end

  factory :answer, class:'AskIt::Answer' do
    attempt
    option { create(:option) }
    question { create(:question) }
    predefined_value { create(:predefined_value) }
  end

end