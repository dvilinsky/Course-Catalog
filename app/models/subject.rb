class Subject < ApplicationRecord
  has_and_belongs_to_many :courses
  has_many :instructors, through: :courses
end
