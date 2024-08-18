# frozen_string_literal: trueFactoryBot.define do
FactoryBot.define do
  factory :survey, class:'AskIt::Survey' do
    name { Faker::Name.name }
    attempts_number { 3 }
    description { Faker::Lorem.paragraph }
  end

  factory :section, class:'AskIt::Section' do
    head_number { Faker::Name.name }
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
  end

  factory :question, class:'AskIt::Question' do
    text { Faker::Lorem.paragraph }
    options_attributes { { option: correct_option_attributes } }
    questions_type_id { AskIt::QuestionsType.multiple_choice }
    mandatory { false }
  end

  factory :predefined_value, class:'AskIt::PredefinedValue' do
    name { Faker::Name.name }
  end

  factory :option, class:'AskIt::Option' do
    text { Faker::Lorem.paragraph }
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
end