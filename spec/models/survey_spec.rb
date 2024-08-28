require 'rails_helper'

RSpec.describe AskIt::Survey, type: :model do

  it 'should not create a valid survey without sections' do
    survey = build(:survey)
    expect(survey).not_to be_valid
  end

  it 'should not create a survey with active flag true and empty questions collection' do
    survey_a = build(:survey, active: true)
    survey_b = create_survey_with_sections(2)
    survey_b.active = true
    survey_b.save

    expect(survey_a).not_to be_valid
    expect(survey_b).to be_valid
    expect(survey_b).to be_persisted
  end

  it 'should create a survey with 3 sections' do
    num_questions = 3
    survey = create_survey_with_sections(num_questions, num_questions)
    expect(survey).to be_persisted
    expect(survey.sections.size).to eq(num_questions)
  end

  it 'should create a survey with 2 questions' do
    num_questions = 2
    survey = create_survey_with_sections(num_questions, 1)
    expect(survey).to be_persisted
    expect(survey.sections.first.questions.size).to eq(num_questions)
  end

  it 'should not create a survey with attempts_number lower than 0' do
    survey = build(:survey, attempts_number: -1)
    expect(survey).not_to be_valid
  end

  it 'should not save survey without all the needed fields' do
    survey_without_name = build(:survey, name: nil)
    survey_without_description = build(:survey, description: nil)
    
    expect(survey_without_name).not_to be_valid
    expect(survey_without_description).not_to be_valid
  end

  it 'should have the correct associations via "has_many_surveys"' do
    lesson = create(:lesson)
    survey = create_survey_with_sections(2, 1)
    survey.lesson_id = lesson.id
    survey.save

    expect(lesson.surveys.first).to eq(survey)
  end

  it 'should pass if all the users have the same score' do
    user_a = create(:user)
    user_b = create(:user)
    survey = create_survey_with_sections(2)

    create_attempt_for(user_a, survey, all: :right)
    create_attempt_for(user_b, survey, all: :right)

    expect(participant_score(user_a, survey)).to eq(participant_score(user_b, survey))
  end
end