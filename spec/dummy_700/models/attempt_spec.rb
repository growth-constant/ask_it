# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AskIt::Attempt, type: :model do
  describe 'validations' do
    def number_of_attempts
      5
    end

    it 'passes if the user has 5 attempts completed' do
      user = create(:user)
      survey = create(:survey, :with_sections, attempts_number: number_of_attempts)

      number_of_attempts.times do
        create(:attempt, participant: user, survey: survey)
      end

      expect(number_of_current_attempts(user, survey)).to eq(number_of_attempts)
    end

    it 'raises error when the User tries to respond more times than acceptable' do
      user = create(:user)
      survey = create(:survey, :with_sections, attempts_number: number_of_attempts)

      number_of_attempts.times do
        create(:attempt, participant: user, survey: survey)
      end

      expect do
        create(:attempt, participant: user, survey: survey)
      end.to raise_error(ActiveRecord::RecordInvalid, /Questionnaire Number of attempts exceeded/)

      expect(number_of_current_attempts(user, survey)).not_to eq(number_of_attempts + 1)
      expect(number_of_current_attempts(user, survey)).to eq(number_of_attempts)
    end
  end

  describe 'scoring' do
    it 'computes the score correctly for a perfect attempt' do
      user = create(:user)
      survey = create(:survey, :with_sections, sections_count: 1, questions_per_section: 4, options_per_question: 5)
      attempt = create(:attempt, :all_correct, participant: user, survey: survey)

      expect(attempt.score).to eq(20)
    end
  end

  # Helper method (you might want to move this to a separate support file)
  def number_of_current_attempts(user, survey)
    AskIt::Attempt.where(participant: user, survey: survey).count
  end
end
