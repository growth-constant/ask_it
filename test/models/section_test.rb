# frozen_string_literal: true

class SectionTest < ActiveSupport::TestCase
  test 'should not create a valid section without questions' do
    section = create_section
    should_not_be_persisted section
  end

  test 'should create a section with 3 questions' do
    num_questions = 3
    survey = create_survey_with_sections(num_questions, 1)
    should_be_persisted survey
    assert_equal survey.sections.first.questions.size, num_questions
  end

  test 'should not save section without all the needed fields' do
    section_without_name = create_section(name: nil)
    should_not_be_persisted section_without_name
  end
end
