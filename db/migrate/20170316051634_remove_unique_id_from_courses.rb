class RemoveUniqueIdFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :unique_id, :string
  end
end
