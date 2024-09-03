require 'rails_helper'

RSpec.describe AskIt::Question, type: :model do
  describe 'validations' do
    it 'should create a valid question' do
      question = create(:question)
      expect(question).to be_persisted
    end

    it 'should create a valid question with multi choices type' do
      question = create(:question, questions_type_id: AskIt::QuestionType.multiple_choice)
      expect(question).to be_persisted
      expect(question.questions_type_id).to eq(AskIt::QuestionType.multiple_choice)
    end

    it 'should not create a valid question with unaccepted type' do
      question = build(:question, questions_type_id: 99)
      expect(question).not_to be_valid
    end

    it 'should create a valid question with predefined_values' do
      question = create(:question, predefined_values: [create(:predefined_value)])
      expect(question).to be_persisted
      expect(question.predefined_values.count).to eq(1)
    end

    it 'should not create a question with a empty or nil questions_type_id field' do
      question = build(:question, questions_type_id: nil)
      expect(question).not_to be_valid
    end

    it 'should not create a question with empty or nil text fields' do
      question1 = build(:question, text: nil)
      question2 = build(:question, text: '')

      expect(question1).not_to be_valid
      expect(question2).not_to be_valid
    end
  end

  describe 'correct options' do
    it 'should return true when passed a correct answer to the question object' do
      question = create(:question, options_count: 6)
      correct_option = question.options.find_by(correct: true)

      expect(question.correct_options).to include(correct_option)

      question.options.where(correct: false).each do |option|
        expect(question.correct_options).not_to include(option)
      end
    end
  end
end