class LaboratoryExamination < ApplicationRecord
  belongs_to :user

  belongs_to :laboratory_result_status, optional: true

  has_many :laboratory_examination_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :laboratory_examination_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [["#{LaboratoryResultStatus}", 'laboratory_result_status_id' ]]
  end


  def laboratory_result_status
    if laboratory_result_status_id
      super
    else
      LaboratoryResultStatus.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :name, :facility, :date, :result, :laboratory_result_status_id,
        laboratory_examination_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
  
end
