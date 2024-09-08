# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AskIt::Survey, type: :model do
  it 'should pass if all the users have the same score' do
    user_a = create(:user)
    user_b = create(:user)
    # survey = create_survey_with_sections(2)
    survey = create(:survey, :with_sections, sections_count: 2)

    create(:attempt, participant: user_a, survey: survey, all_correct: true)
    create(:attempt, participant: user_b, survey: survey, all_correct: true)

    expect(participant_score(user_a, survey)).to eq(participant_score(user_b, survey))
  end
end
