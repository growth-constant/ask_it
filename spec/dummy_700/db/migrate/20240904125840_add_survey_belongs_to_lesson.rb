class AddSurveyBelongsToLesson < ActiveRecord::Migration[7.0]
  def change
    # create belongs to association for survey_surveys
    add_column :survey_surveys, :lesson_id, :integer
    add_foreign_key :survey_surveys, :lessons, column: :lesson_id
  end
end
