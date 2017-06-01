module Lms
  class Course < ApplicationRecord
    before_validation :generate_course_code

    has_many :assignments, dependent: :destroy
    has_many :course_links, dependent: :destroy
    has_many :lessons, dependent: :destroy
    has_many :enrollments, dependent: :destroy
    has_many :students, through: :enrollments, class_name: 'User'
    belongs_to :teacher, class_name: 'User'

    has_many :course_attachments, foreign_key: :owner_id, dependent: :destroy
    accepts_nested_attributes_for :course_attachments, reject_if: :all_blank, allow_destroy: true

    validates_presence_of :name, :course_code
    validates_uniqueness_of :course_code

    def to_s
      name
    end

    def self.safe_attributes
      [:name, :description, :course_code, :teacher_id,
       course_attachments_attributes: [Attachment.safe_attributes] ]
    end

    private

    def generate_course_code
      code = SecureRandom.hex(3)
      if Course.find_by(course_code: code) != nil
        generate_course_code
      else
        self.course_code ||= code
      end
    end

    alias :course_files :course_attachments
  end
end
