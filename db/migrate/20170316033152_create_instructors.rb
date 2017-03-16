class CreateInstructors < ActiveRecord::Migration[5.0]
  def change
    create_table :instructors do |t|
      t.string :unique_id
      t.string :f_name
      t.string :m_name
      t.string :l_name
      t.string :email
      t.string :kind

      t.timestamps
    end
    add_index :instructors, :unique_id
  end
end
