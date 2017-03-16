require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create'(name: 'Luke', movie: movies.first)

f = File.read('instructor.json')
data = JSON.parse(f)

data.each do |d|
  instructor = Instructor.create(unique_id: d['id'],
                                  f_name: d['first'],
                                  m_name: d['middle'],
                                  l_name: d['last'],
                                  email:  d['email'],
                                  kind:   "instructor")

end
$staff = Instructor.find_by(l_name: "Staff")

f = File.read('subject.json')
data = JSON.parse(f)

data.each do |d|
  Subject.create(unique_id: d['id'],
                 name: d['name'],
                 abbrv: d['abbreviation'],
                 kind: "subject")
end

def find_instructor(d)
  desc = d['description']
  start = desc.index("Mr") || desc.index("Ms") #will be nill if staff instructor
  lastname = desc[(start+4)...desc.length] if !start.nil? #gets the last name of instructor
  instructor = Instructor.find_by(l_name: lastname) || $staff
  return instructor
end

f = File.read('course.json')
courses = JSON.parse(f)
last_names = Instructor.pluck(:l_name)
#this ends up being slow, but luckily it only happens once
courses.each do |d|
  instructor = find_instructor(d)
  subjects = []
  d['subjects'].each do |x|
    subjects << x['id']
  end
  instructor.courses.build(code: d['code'],
                           name: d['name'],
                           description: d['description'],
                           kind: "course",
                           subjects: Subject.where(:unique_id => subjects)).save
end
