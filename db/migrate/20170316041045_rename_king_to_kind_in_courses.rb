class RenameKingToKindInCourses < ActiveRecord::Migration[5.0]
  def change
    rename_column :courses, :king, :kind
  end
end
