# frozen_string_literal: true

module AskIt
  # Handles creation and management of surveys
  class SurveysController < ActionController::Base
    before_action :load_survey, only: %i[show edit update]

    def index
      @surveys = AskIt::Survey.all
    end

    def new
      @survey = AskIt::Survey.new
    end

    def create
      @survey = AskIt::Survey.new(survey_params)
      if @survey.valid? && @survey.save
        redirect_to surveys_path, notice: I18n.t('surveys_controller.create')
      else
        render :new
      end
    end

    def edit
      # @survey is already loaded by before_action
    end

    def show
      # @survey is already loaded by before_action
    end

    def update
      if @survey.update(survey_params)
        redirect_to surveys_path, notice: I18n.t('surveys_controller.update')
      else
        render :edit
      end
    end

    private

    def load_survey
      @survey = AskIt::Survey.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to surveys_path, alert: 'Survey not found'
    end

    def survey_params
      params.require(:survey).permit(
        :name, :description, :active,
        sections_attributes: [:id, :name, :_destroy,
                              { questions_attributes: [:id, :text, :question_type, :_destroy,
                                                       { options_attributes: %i[id text _destroy] }] }]
      )
    end
  end
end
