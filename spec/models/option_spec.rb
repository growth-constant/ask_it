# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AskIt::Option, type: :model do
  describe 'validations' do
    it 'should create a valid option' do
      option = create(:option)
      expect(option).to be_persisted
    end

    it 'should create a valid option with multi choices type' do
      option = create(:option, options_type_id: AskIt::OptionsType.multi_choices)

      expect(option).to be_persisted
      expect(option.options_type_id).to eq(AskIt::OptionsType.multi_choices)
    end

    it 'should create a valid option with single choice type' do
      option = create(:option, options_type_id: AskIt::OptionsType.single_choice)

      expect(option).to be_persisted
      expect(option.options_type_id).to eq(AskIt::OptionsType.single_choice)
    end

    it 'should create a valid option with number type' do
      option = create(:option, options_type_id: AskIt::OptionsType.number)

      expect(option).to be_persisted
      expect(option.options_type_id).to eq(AskIt::OptionsType.number)
    end

    it 'should create a valid option with text type' do
      option = create(:option, options_type_id: AskIt::OptionsType.text)

      expect(option).to be_persisted
      expect(option.options_type_id).to eq(AskIt::OptionsType.text)
    end

    it 'should create a valid option with large_text type' do
      option = create(:option, options_type_id: AskIt::OptionsType.large_text)

      expect(option).to be_persisted
      expect(option.options_type_id).to eq(AskIt::OptionsType.large_text)
    end

    it 'should not create an option with an unaccepted type' do
      option = build(:option, options_type_id: 99)

      expect(option).not_to be_valid
    end

    it 'should not create an option with an empty or nil options_type_id field' do
      option = build(:option, options_type_id: nil)

      expect(option).not_to be_valid
    end

    context 'text field validations' do
      it 'should create an option with empty or nil text fields for text or number types' do
        option_a = create(:option, text: '', options_type_id: AskIt::OptionsType.text)
        option_b = create(:option, text: nil, options_type_id: AskIt::OptionsType.text)
        option_c = create(:option, text: '', options_type_id: AskIt::OptionsType.number)
        option_d = create(:option, text: nil, options_type_id: AskIt::OptionsType.number)

        [option_a, option_b, option_c, option_d].each do |option|
          expect(option).to be_persisted
        end
      end

      it 'should not create an option with empty or nil text fields for multi_choices or single_choice types' do
        invalid_types = [
          AskIt::OptionsType.multi_choices,
          AskIt::OptionsType.single_choice,
          AskIt::OptionsType.multi_choices_with_text,
          AskIt::OptionsType.single_choice_with_text,
          AskIt::OptionsType.multi_choices_with_number,
          AskIt::OptionsType.single_choice_with_number
        ]

        invalid_types.each do |type|
          option_a = build(:option, text: '', options_type_id: type)
          option_b = build(:option, text: nil, options_type_id: type)

          expect(option_a).not_to be_valid
          expect(option_b).not_to be_valid
        end
      end
    end
  end

  describe 'correct flag' do
    it 'should be true if option is set as correct and false if set as incorrect' do
      option_a = create(:option, correct: false)
      option_b = create(:option, correct: true)

      expect(option_a).not_to be_correct
      expect(option_b).to be_correct
    end
  end

  describe 'weight synchronization' do
    it 'should synchronize weights with the correct flag' do
      option_a = create(:option, correct: false)
      option_b = create(:option, correct: true)
      option_c = create(:option, correct: true, weight: 5)

      expect(option_a.weight).to eq(0)
      expect(option_b.weight).to eq(1)
      expect(option_c.weight).to eq(5)
    end
  end
end
