module Lms
  class Enrollment < ApplicationRecord
    belongs_to :course
    belongs_to :student, class_name: 'User'

    validates_uniqueness_of :course_id, scope: :student
    validates_uniqueness_of :student_id, scope: :course
  end
end
