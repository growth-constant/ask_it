class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.timestamps
    end

    # create belongs to association for survey_surveys
    add_column :survey_surveys, :lesson_id, :integer
    add_foreign_key :survey_surveys, :lessons, column: :lesson_id
  end
end
