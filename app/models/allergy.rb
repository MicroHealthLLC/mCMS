class Allergy < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'allergy_type_id', class_name: 'Icd10datum'
  belongs_to :allergy_status, optional: true

  has_many :allergy_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :allergy_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id

  before_validation do
    if self.snomed.blank?
      errors[:base] << "Allergy type cannot be blank"
    end
  end

  def allergy_type
    icdcm_code
  end

  def self.enumeration_columns
    [
        ["#{AllergyStatus}", 'allergy_status_id']
    ]
  end

  def self.include_enumerations
    includes(:allergy_status).
        references(:allergy_status)
  end

  def self.csv_attributes
    [
    'Allergy type',

    'Allergy date',
    'Allergy status'

    ]
  end

  def allergy_status
    if allergy_status_id
      super
    else
      AllergyStatus.default
    end
  end


  def to_s
    snomed
  end


  def self.safe_attributes
    [
        :user_id, :allergy_type_id, :medication,
        :allergy_date, :allergy_status_id, :description, :snomed,
        allergy_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Allergy ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Allergy "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Allergy Type: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Allergy Status: ", " #{allergy_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Allergy date: ", " #{allergy_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Allergy ##{id} </h2>"
    output<<"<b>Allergy Type: : </b> #{snomed}<br/>"
    output<<"<b>Allergy Status: </b> #{allergy_status}<br/>"
    output<<"<b>Allergy date: </b> #{allergy_date}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
