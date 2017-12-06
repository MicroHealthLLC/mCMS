class FamilyHistory < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :family_type, optional: true
  belongs_to :family_status, optional: true

  has_many :family_history_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :family_history_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{FamilyType}", 'family_type_id'],
        ["#{FamilyStatus}", 'family_status_id']
    ]
  end

  def self.include_enumerations
    includes(:family_status, :family_type).
        references(:family_status, :family_type)
  end

  def self.csv_attributes
    [
    'Name',
    'Snomed',
    'Date identified',
    'Family status',
    'Family type'
    ]
  end

  def family_type
    if family_type_id
      super
    else
      FamilyType.default
    end
  end

  def family_status
    if family_status_id
      super
    else
      FamilyStatus.default
    end
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :family_status_id, :snomed,
     :family_type_id, :description]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Family History ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Family History "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Family History Status: ", " #{family_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Family History Type: ", " #{family_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date identified: ", " #{date_identified}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Familty History ##{id} </h2><br/>"
    output<<"<b>Name : </b> #{name}<br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Family History Type : </b> #{family_type}<br/>"
    output<<"<b>Family History Status : </b> #{family_status}<br/>"
    output<<"<b>Date identified : </b> #{date_identified}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end


end
