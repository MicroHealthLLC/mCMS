module Lms
  class StudentAssignment < ApplicationRecord
    belongs_to :assignment
    belongs_to :student, class_name: 'User'

  end
end
