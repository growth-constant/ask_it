module Support
  module ModelsCreate
    def create_survey_with_sections(num, sections_num = 1)
      survey = create(:survey)
      sections_num.times do
        section = create(:section)
        num.times do
          question = create(:question)
          num.times { create(:correct_option, question: question) }
          section.questions << question
        end
        survey.sections << section
      end
      survey.save
      survey
    end

    def create_attempt_for(user, survey, opts = {})
      correct_options = opts.fetch(:all, :wrong) == :right ? survey.correct_options : survey.correct_options[1..-1]
      create(:attempt, user: user, survey: survey, options: correct_options)
      enddefcreate_answer(opts = {})
      survey = create_survey_with_sections(1)
      section = survey.sections.first
      question = section.questions.first
      option = question.options.first
      attempt = create(:attempt, user: create(:user), survey: survey)
      AskIt::Answer.create({ option: option, attempt: attempt, question: question }.merge(opts))
    end
  end
end