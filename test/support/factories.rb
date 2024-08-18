# frozen_string_literal: true

# Factories

module Factories

  # Create a AskIt::Survey
  def create_survey(opts = {})
    AskIt::Survey.create({
      name: ::Faker::Name.name,
      attempts_number: 3,
      description: ::Faker::Lorem.paragraph(1)
    }.merge(opts))
  end

  # Create a AskIt::Section
  def create_section(opts = {})
    AskIt::Section.create({
      head_number: ::Faker::Name.name,
      name: ::Faker::Name.name,
      description: ::Faker::Lorem.paragraph(1)
    }.merge(opts))
  end

  # Create a AskIt::Question
  def create_question(opts = {})
    AskIt::Question.create({
      text: ::Faker::Lorem.paragraph(1),
      options_attributes: { option: correct_option_attributes },
      questions_type_id: AskIt::QuestionsType.multiple_choice,
      mandatory: false
    }.merge(opts))
  end

  # Create a AskIt::PredefinedValue
  def create_predefined_value(opts = {})
    AskIt::PredefinedValue.create({
      name: ::Faker::Name.name
    }.merge(opts))
  end

  # Create a AskIt::option but not saved
  def new_option(opts = {})
    AskIt::Option.new(option_attributes.merge(opts))
  end

  # Create a AskIt::Option
  def create_option(opts = {})
    AskIt::Option.create(option_attributes.merge(opts))
  end

  def option_attributes
    { text: ::Faker::Lorem.paragraph(1),
      options_type_id: AskIt::OptionsType.multi_choices }
  end

  def correct_option_attributes
    option_attributes.merge(correct: true)
  end

  def create_attempt(opts = {})
    attempt = AskIt::Attempt.create do |t|
      t.survey = opts.fetch(:survey, nil)
      t.participant = opts.fetch(:user, nil)
      opts.fetch(:options, []).each do |option|
        t.answers.new(option: option, question: option.question, attempt: t)
      end
    end
  end

  def create_survey_with_sections(num, sections_num = 1)
    survey = create_survey
    sections_num.times do
      section = create_section
      num.times do
        question = create_question
        num.times do
          question.options << create_option(correct_option_attributes)
        end
        section.questions << question
      end
      survey.sections << section
    end
    survey.save
    survey
  end

  def create_attempt_for(user, survey, opts = {})
    if opts.fetch(:all, :wrong) == :right
      correct_survey = survey.correct_options
      create_attempt(options: correct_survey,
                    user: user,
                    survey: survey)
    else
      incorrect_survey = survey.correct_options
      incorrect_survey.shift
      create_attempt(options: incorrect_survey,
                    user: user,
                    survey: survey)
    end
  end

  def create_answer(opts = {})
    survey = create_survey_with_sections(1)
    section = survey.sections.first
    question = section.questions.first
    option   = section.questions.first.options.first
    attempt = create_attempt(user: create_user, survey: survey)
    AskIt::Answer.create({ option: option, attempt: attempt, question: question }.merge(opts))
  end

  def create_answer_with_option_type(options_type, mandatory = false)
    option = create_option(options_type_id: options_type)
    question = create_question(questions_type_id: AskIt::QuestionsType.multiple_choice, mandatory: mandatory)
    section = create_section
    survey = create_survey

    question.options << option
    section.questions << question
    survey.sections << section
    survey.save

    attempt = create_attempt(user: create_user, survey: survey)

    [survey, option, attempt, question]
  end

  # Dummy Model from Dummy Application
  def create_user
    User.create(name: Faker::Name.name)
  end

  def create_lesson
    Lesson.create(name: Faker::Company.catch_phrase)
  end
end
