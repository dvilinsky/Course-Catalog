class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :unique_id
      t.string :name
      t.string :abbrv
      t.string :kind

      t.timestamps
    end
    add_index :subjects, :unique_id
  end
end
