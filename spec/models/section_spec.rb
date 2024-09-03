require 'rails_helper'

RSpec.describe AskIt::Section, type: :model do
  describe 'validations' do
    it 'does not create a valid section without questions' do
      section = build(:section)
      expect(section).not_to be_valid
    end

    it 'creates a section with 3 questions' do
      survey = create(:survey, :with_sections, sections_count: 1, questions_per_section: 3)
      section = survey.sections.first

      expect(survey).to be_valid
      expect(section.questions.size).to eq(3)
    end

    it 'does not save section without all the needed fields' do
      section_without_name = build(:section, name: nil)
      expect(section_without_name).not_to be_valid
    end
  end
end