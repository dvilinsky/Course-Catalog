class Course < ApplicationRecord
  belongs_to :instructor
  has_and_belongs_to_many :subjects
  has_many :enrollments
  has_many :users, through: :enrollments
end
