# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AskIt::Answer do
  describe 'validations' do
    it 'creates a valid answer' do
      answer = create(:answer, :with_survey_and_section)
      expect(answer).to be_persisted
    end

    it 'does not create an answer with a nil option' do
      answer = build(:answer, :with_survey_and_section, option: nil)
      expect(answer).not_to be_valid
    end

    it 'does not create an answer with a nil question' do
      answer = build(:answer, :with_survey_and_section, question: nil)
      expect(answer).not_to be_valid
    end
  end

  describe 'option types' do
    context 'when option is number type' do
      it 'creates an answer with a option_number field' do
        answer = create(:answer, :with_survey_and_section, :with_number_option, option_number: 12, mandatory: true)
        expect(answer).to be_persisted
      end

      it 'does not create an answer with a nil option_number field' do
        answer = build(:answer, :with_survey_and_section, :with_number_option, option_number: nil, mandatory: true)
        expect(answer).not_to be_valid
      end
    end

    context 'when option is text type' do
      it 'creates an answer with a option_text field' do
        answer = create(:answer, :with_survey_and_section, :with_text_option, option_text: Faker::Lorem.word, mandatory: true)
        expect(answer).to be_persisted
      end

      it 'does not create an answer with a nil option_text field' do
        answer = build(:answer, :with_survey_and_section, :with_text_option, option_text: nil, mandatory: true)
        expect(answer).not_to be_valid
      end
    end

    context 'when option is large_text type' do
      it 'creates an answer with a option_text field' do
        answer = create(:answer, :with_survey_and_section, :with_large_text_option, option_text: Faker::Lorem.paragraph, mandatory: true)
        expect(answer).to be_persisted
      end

      it 'does not create an answer with a nil option_text field' do
        answer = build(:answer, :with_survey_and_section, :with_large_text_option, option_text: nil, mandatory: true)
        expect(answer).not_to be_valid
      end
    end

    context 'when option is multi_choices_with_text type' do
      it 'creates an answer with a option_text field' do
        answer = create(:answer, :with_multi_choices_with_text_option, :with_question_only, mandatory: true)
        create(:survey, :with_section_and_question_defined, question: answer.question)
        expect(answer).to be_persisted
      end

      it 'has a present option_text' do
        answer = create(:answer, :with_multi_choices_with_text_option, :with_question_only, mandatory: true)
        expect(answer.option_text).to be_present
      end

      it 'does not create an answer with empty option_text field' do
        answer = build(:answer, :with_survey_and_section, :with_multi_choices_with_text_option, option_text: nil, mandatory: true)
        expect(answer).not_to be_valid
      end

      it 'has correct error message for empty option_text' do
        answer = build(:answer, :with_survey_and_section, :with_multi_choices_with_text_option, option_text: nil, mandatory: true)
        answer.valid?
        expect(answer.errors[:option_text]).to eq(["can't be blank"])
      end
    end

    context 'when option is single_choice_with_text type' do
      it 'does not create an answer with empty option_text field' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_with_text_option, option_text: nil, mandatory: true)
        expect(answer).not_to be_valid
      end

      it 'has correct error message for empty option_text' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_with_text_option, option_text: nil, mandatory: true)
        answer.valid?
        expect(answer.errors[:option_text]).to eq(["can't be blank"])
      end
    end

    context 'when option is multi_choices_with_number type' do
      it 'does not create an answer with empty option_number field' do
        answer = build(:answer, :with_survey_and_section, :with_multi_choices_with_number_option, option_number: nil, mandatory: true)
        expect(answer).not_to be_valid
      end

      it 'has correct error message for empty option_number' do
        answer = build(:answer, :with_survey_and_section, :with_multi_choices_with_number_option, option_number: nil, mandatory: true)
        answer.valid?
        expect(answer.errors[:option_number]).to eq(["can't be blank"])
      end
    end

    context 'when option is single_choice_with_number type' do
      it 'does not create an answer with empty option_number field' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_with_number_option, option_number: nil, mandatory: true)
        expect(answer).not_to be_valid
      end

      it 'has correct error message for empty option_number' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_with_number_option, option_number: nil, mandatory: true)
        answer.valid?
        expect(answer.errors[:option_number]).to eq(["can't be blank"])
      end
    end

    context 'when option is multi_choices type' do
      it 'creates an answer with options with multi_choices type' do
        answer = create(:answer, :with_survey_and_section, :with_multi_choices_option, option_text: Faker::Lorem.word, mandatory: true)
        expect(answer).to be_persisted
      end

      it 'has empty text field for multi_choices type' do
        answer = create(:answer, :with_survey_and_section, :with_multi_choices_option, option_text: Faker::Lorem.word, mandatory: true)
        expect(answer.option_text).to be_nil
      end
    end

    context 'when option is single_choice type' do
      it 'creates an answer with options with single_choice type' do
        answer = create(:answer, :with_survey_and_section, :with_single_choice_option, mandatory: true)
        expect(answer).to be_persisted
      end

      it 'has empty text field for single_choice type' do
        answer = create(:answer, :with_survey_and_section, :with_single_choice_option, mandatory: true)
        expect(answer.option_text).to be_nil
      end

      it 'creates an answer with a predefined_value_id field' do
        predefined_value = create(:predefined_value)
        answer = create(:answer, :with_survey_and_section, :with_single_choice_option, predefined_value: predefined_value, mandatory: true)
        expect(answer.predefined_value_id).to eq(predefined_value.id)
      end

      it 'does not create an answer with an empty predefined_value_id field' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_option, predefined_value: nil, mandatory: true)
        answer.question.predefined_values << create(:predefined_value)
        expect(answer).not_to be_valid
      end

      it 'has correct error message for empty predefined_value_id' do
        answer = build(:answer, :with_survey_and_section, :with_single_choice_option, predefined_value: nil, mandatory: true)
        answer.question.predefined_values << create(:predefined_value)
        answer.valid?
        expect(answer.errors[:predefined_value_id]).to eq(["can't be blank"])
      end
    end
  end

  describe 'multiple answers' do
    it 'can create an answer already made to the same attempt' do
      first_answer = create(:answer, :with_survey_and_section, :with_single_choice_option, mandatory: true)
      second_answer = create(:answer, attempt: first_answer.attempt, question: first_answer.question, option: first_answer.option)
      expect(first_answer).to be_persisted
      expect(second_answer).to be_persisted
    end
  end
end
