class Socioeconomic < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :icdcm_code, :foreign_key => 'icdcm_code_id', class_name: 'Icd10datum'
  belongs_to :socioeconomic_type, optional: true
  belongs_to :socioeconomic_status, optional: true

  has_many :socioeconomic_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :socioeconomic_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :name

  def self.enumeration_columns
    [
        ["#{SocioeconomicType}", 'socioeconomic_type_id'],
        ["#{SocioeconomicStatus}", 'socioeconomic_status_id']
    ]
  end

  def socioeconomic_type
    if socioeconomic_type_id
      super
    else
      SocioeconomicType.default
    end
  end

  def socioeconomic_status
    if socioeconomic_status_id
      super
    else
      SocioeconomicStatus.default
    end
  end


  def to_s
    name
  end

  def self.safe_attributes
    [:name, :user_id, :icdcm_code_id, :date_identified, :date_resolved, :snomed,
     :socioeconomic_status_id, :socioeconomic_type_id, :description]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Socioeconomic ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Socioeconomic "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Snomed code: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Status: ", " #{socioeconomic_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Type: ", " #{socioeconomic_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date identified: ", " #{date_identified}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date resolved: ", " #{date_resolved}"]], :column_widths => [ 150, 373])

    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Socioeconomic ##{id} </h2>"
    output<<"<b>Name: </b> #{name}<br/>"
    output<<"<b>Snomed code: </b> #{snomed}<br/>"
    output<<"<b>Status: </b> #{socioeconomic_status}<br/>"
    output<<"<b>Type: </b> #{socioeconomic_type}<br/>"
    output<<"<b>Date identified: </b> #{date_identified}<br/>"
    output<<"<b>Date resolved: </b> #{date_resolved}<br/>"
    output<<"<b>Description: </b> #{description}<br/>"

    output.html_safe
  end

end
