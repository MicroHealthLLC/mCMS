module Lms
  class LessonAttachment < Attachment
    belongs_to :owner, class_name: 'Lms::Lesson'
  end
end