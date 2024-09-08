# frozen_string_literal: true

module Support
  module ModelsCreate
    def create_survey_with_sections(num, sections_num = 1)
      survey = build(:survey)
      sections_num.times do
        section = build(:section)
        num.times do
          question = build(:question)
          num.times { create(:correct_option, question: question) }
          question.save
          section.questions << question
        end
        section.save
        survey.sections << section
      end
      survey.save
      survey
    end

    def create_attempt_for(user, survey, **opts)
      correct_options = opts.fetch(:all, :wrong) == :right ? survey.correct_options : survey.correct_options[1..]
      create(:attempt, participant: user, survey: survey, answers_array: correct_options.map do |option|
                                                                           build(:answer, option: option)
                                                                         end)
    end

    def create_answer(opts = {})
      survey = create_survey_with_sections(1)
      section = survey.sections.first
      question = section.questions.first
      option = question.options.first
      attempt = create(:attempt, participant: create(:user), survey: survey)
      AskIt::Answer.create({ option: option, attempt: attempt, question: question }.merge(opts))
    end

    def create_lesson(_survey)
      Lesson.create(name: Faker::Company.catch_phrase)
    end
  end
end
