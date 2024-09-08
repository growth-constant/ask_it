# frozen_string_literal: true

# frozen_string_literal: trueFactoryBot.define do
FactoryBot.define do
  factory :survey, class: 'AskIt::Survey' do
    name { Faker::Name.name }
    attempts_number { 3 }
    active { true }
    description { Faker::Lorem.paragraph }

    trait :with_sections do
      transient do
        sections_count { 2 }
        questions_per_section { 3 }
        options_per_question { questions_per_section }
      end

      after(:build) do |survey, evaluator|
        survey.sections = build_list(:section, evaluator.sections_count, survey: survey) do |section|
          section.questions = build_list(:question, evaluator.questions_per_section, section: section)
          section.questions.each do |question|
            question.options = build_list(:option, evaluator.options_per_question, question: question, correct: true)
          end
        end
      end
    end

    trait :with_section_and_question_defined do
      transient do
        question { create(:question) }
      end

      sections { build_list(:section, 1, questions: [question]) }
    end
  end

  factory :section, class: 'AskIt::Section' do
    head_number { Faker::Name.name }
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end

  ###
  # Questions
  ###

  factory :question, class: 'AskIt::Question' do
    text { Faker::Lorem.paragraph }
    # options { [create(:option)] }
    questions_type_id { AskIt::QuestionType.multiple_choice }
    mandatory { false }
    predefined_values { [] }

    transient do
      options_count { 1 }
    end

    after(:build) do |question, evaluator|
      # Create regular options
      evaluator.options_count.times do
        question.options << build(:option, question: question)
      end

      # Ensure at least one correct option
      question.options << build(:option, question: question, correct: true)
    end
  end

  ###
  # Options
  ###

  factory :predefined_value, class: 'AskIt::PredefinedValue' do
    name { Faker::Name.name }
  end

  factory :option, class: 'AskIt::Option' do
    text { Faker::Lorem.paragraph }
    options_type_id { AskIt::OptionsType.multi_choices }
    correct { false }
    question

    factory :correct_option do
      correct { true }
    end

    trait :correct do
      correct { true }
    end

    trait :with_text do
      options_type_id { AskIt::OptionsType.text }
    end

    trait :with_number do
      options_type_id { AskIt::OptionsType.number }
    end

    trait :with_large_text do
      options_type_id { AskIt::OptionsType.large_text }
    end
  end

  factory :user do
    name { Faker::Name.name }
  end

  ###
  # Lessons
  ###

  factory :lesson, class: 'Lesson' do
    name { Faker::Company.catch_phrase }
  end

  ###
  # Attempts
  ###

  factory :attempt, class: 'AskIt::Attempt' do
    survey
    participant { create(:user) }

    transient do
      answers_array { [] }
      all_correct { false }
    end

    after(:build) do |attempt, evaluator|
      if evaluator.answers_array.any?
        evaluator.answers_array.each do |answer|
          attempt.answers << answer
        end
      elsif evaluator.all_correct
        correct_options = attempt.survey.correct_options
        attempt.answers = correct_options.map do |option|
          build(:answer, option: option, question: option.question, attempt: attempt)
        end
      else
        incorrect_options = attempt.survey.correct_options[1..]
        attempt.answers = incorrect_options.map do |option|
          build(:answer, option: option, question: option.question, attempt: attempt)
        end
      end
    end

    trait :all_correct do
      all_correct { true }
    end

    trait :all_incorrect do
      all_correct { false }
    end
  end

  ###
  # Answers
  ###

  factory :answer, class: 'AskIt::Answer' do
    trait :with_question_only do
      transient do
        mandatory { false }
        options_type { AskIt::OptionsType.multi_choices }
      end

      question do
        build(:question, mandatory: mandatory, questions_type_id: AskIt::QuestionType.multiple_choice, options_count: 0)
      end
    end

    trait :with_survey_and_section do
      transient do
        survey { create(:survey, :with_sections, questions_per_section: 1) }
        section { survey.sections.first }
        mandatory { false }
      end

      question { section.questions.first }
      option { section.questions.first.options.first }
      attempt { create(:attempt, survey: survey) }
      option_text { Faker::Lorem.word }

      after(:build) do |answer, evaluator|
        answer.question.update(mandatory: evaluator.mandatory) if answer.question.present?
      end
    end

    trait :with_predefined_value do
      association :predefined_value
    end

    trait :with_number_option do
      option { create(:option, options_type_id: AskIt::OptionsType.number, question: question) }
      option_text { nil }
      option_number { Faker::Number.number(digits: 2) }
    end

    trait :with_text_option do
      option { create(:option, options_type_id: AskIt::OptionsType.text, question: question) }
      option_text { Faker::Lorem.word }
      option_number { nil }
    end

    trait :with_large_text_option do
      option { create(:option, options_type_id: AskIt::OptionsType.large_text, question: question) }
      option_text { Faker::Lorem.paragraph }
      option_number { nil }
    end

    trait :with_multi_choices_option do
      option { create(:option, options_type_id: AskIt::OptionsType.multi_choices, question: question) }
      option_text { nil }
      option_number { nil }
    end

    trait :with_multi_choices_with_text_option do
      option { create(:option, options_type_id: AskIt::OptionsType.multi_choices_with_text, question: question) }
      option_text { Faker::Lorem.word }
      option_number { nil }
    end

    trait :with_multi_choices_with_number_option do
      option { create(:option, options_type_id: AskIt::OptionsType.multi_choices_with_number, question: question) }
      option_text { nil }
      option_number { Faker::Number.number(digits: 2) }
    end

    trait :with_single_choice_option do
      option { create(:option, options_type_id: AskIt::OptionsType.single_choice, question: question) }
      option_text { nil }
      option_number { nil }
    end

    trait :with_single_choice_with_number_option do
      option { create(:option, options_type_id: AskIt::OptionsType.single_choice_with_number, question: question) }
      option_text { nil }
      option_number { Faker::Number.number(digits: 2) }
    end

    trait :with_single_choice_with_text_option do
      option { create(:option, options_type_id: AskIt::OptionsType.single_choice_with_text, question: question) }
      option_text { Faker::Lorem.word }
      option_number { nil }
    end
  end
end
