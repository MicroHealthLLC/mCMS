class ProblemList < ApplicationRecord
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :problem_type, optional: true
  belongs_to :problem_status, optional: true

  has_many :problem_list_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :problem_list_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :icdcm_code_id

  def problem_type
    if problem_type_id
      super
    else
      ProblemType.default
    end
  end

  def problem_status
    if problem_status_id
      super
    else
      ProblemStatus.default
    end
  end


  def to_s
    icdcm_code
  end

  def self.safe_attributes
    [:icdcm_code_id, :user_id, :date_onset, :date_resolved, :problem_status_id, :problem_type_id, :description,
     problem_list_attachments_attributes: [Attachment.safe_attributes]]
  end
end
