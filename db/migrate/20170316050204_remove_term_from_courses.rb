class RemoveTermFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :term, :string
  end
end
