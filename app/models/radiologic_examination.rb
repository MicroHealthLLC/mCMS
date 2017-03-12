class RadiologicExamination < ApplicationRecord
  belongs_to :user

  belongs_to :radiologic_result_status, optional: true

  has_many :radiologic_examination_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :radiologic_examination_attachments, reject_if: :all_blank, allow_destroy: true


  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [["#{RadiologicResultStatus}", 'radiologic_result_status_id' ]]
  end

  def radiologic_result_status
    if radiologic_result_status_id
      super
    else
      RadiologicResultStatus.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :name, :facility, :date, :result, :radiologic_result_status_id,
        radiologic_examination_attachments_attributes: [Attachment.safe_attributes]
    ]
  end
end
