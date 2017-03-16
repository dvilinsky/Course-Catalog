class CoursesSubjectsTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :courses, :subjects
  end
end
