class Course < ApplicationRecord
  belongs_to :instructor
  has_and_belongs_to_many :subjects
end
