# frozen_string_literal: true

class AskIt::AttemptsController < ActionController::Base
  # Handles creation and management of survey attempts
  # helper 'ask_it/surveys'
  # include AskIt::SurveysHelper

  def new
    @survey = Survey.active.last
    @attempt = @survey.attempts.new
    @attempt.answers.build
    @participant = current_user # Adjust as needed
  end

  def create
    @survey = Survey.active.last
    @attempt = @survey.attempts.new(attempt_params)
    @attempt.participant = current_user # Adjust as needed

    if @attempt.save
      redirect_to new_ask_it_attempt_path, notice: t('.success')
    else
      flash.now[:error] = @attempt.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def attempt_params
    params.require(:attempt).permit(answers_attributes: %i[question_id option_id option_text option_number predefined_value_id])
  end
end
