class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :unique_id
      t.string :name
      t.text :description
      t.string :term
      t.string :kind

      t.timestamps
    end
    add_foreign_key :courses, :instructors
    add_index :courses, :unique_id
  end
end
