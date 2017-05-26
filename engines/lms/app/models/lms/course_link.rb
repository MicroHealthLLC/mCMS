module Lms
  class CourseLink < ApplicationRecord
    belongs_to :course
  end
end
