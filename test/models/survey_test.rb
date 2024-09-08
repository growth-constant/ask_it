# frozen_string_literal: true

class SurveyTest < ActiveSupport::TestCase
  test 'should not create a valid survey without sections' do
    survey = create_survey
    should_not_be_persisted survey
  end

  test 'should not create a survey with active flag true and empty questions collection' do
    survey_a = create_survey(active: true)
    survey_b = create_survey_with_sections(2)
    survey_b.active = true
    survey_b.save

    should_not_be_persisted survey_a
    should_be_persisted survey_b
    should_be_true survey_b.valid?
  end

  test 'should create a survey with 3 sections' do
    num_questions = 3
    survey = create_survey_with_sections(num_questions, num_questions)
    should_be_persisted survey
    assert_equal survey.sections.size, num_questions
  end

  test 'should create a survey with 2 questions' do
    num_questions = 2
    survey = create_survey_with_sections(num_questions, 1)
    should_be_persisted survey
    assert_equal survey.sections.first.questions.size, num_questions
  end

  test 'should not create a survey with attempts_number lower than 0' do
    survey = create_survey(attempts_number: -1)
    should_not_be_persisted survey
  end

  test 'should not save survey without all the needed fields' do
    create_survey(name: nil)
    create_survey(description: nil)
    %w[name description].each do |suffix|
      should_not_be_persisted eval("survey_without_#{suffix}")
    end
  end

  test 'should have the correct associations via "has_many_surveys"' do
    lesson = create_lesson
    survey = create_survey_with_sections(2, 1)
    survey.lesson_id = lesson.id
    survey.save

    assert_equal survey, lesson.surveys.first
  end
end
