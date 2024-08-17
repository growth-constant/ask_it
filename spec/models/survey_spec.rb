require 'rails_helper'

RSpec.describe AskIt::Survey, type::model do
  it 'should pass if all the users have the same score' do
    user_a = create_user
    user_b = create_user
    survey = create_survey_with_sections(2)

    create_attempt_for(user_a, survey, all::right)
    create_attempt_for(user_b, survey, all::right)

    expect(participant_score(user_a, survey)).to eq(participant_score(user_b, survey))
  end
end