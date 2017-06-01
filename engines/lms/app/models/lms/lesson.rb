module Lms
  class Lesson < ApplicationRecord
    belongs_to :course
    belongs_to :user

    has_many :comments, dependent: :destroy

    has_many :lesson_attachments, foreign_key: :owner_id, dependent: :destroy
    accepts_nested_attributes_for :lesson_attachments, reject_if: :all_blank, allow_destroy: true

    validates_presence_of :title, :content, :course_id, :user_id
    validates_uniqueness_of :title, scope: :course_id

    def to_s
      title
    end

    def self.safe_attributes
      [:title, :content, :course_id, :user_id,
       lesson_attachments_attributes: [Attachment.safe_attributes] ]
    end
  end
end
