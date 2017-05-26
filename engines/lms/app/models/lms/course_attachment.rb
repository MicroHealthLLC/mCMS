module Lms
  class CourseAttachment < Attachment
    belongs_to :owner, class_name: 'Lms::Course'
  end
end