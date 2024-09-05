class AddSurveyBelongsLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :survey_surveys, :lesson_id, :integer
  end
end
