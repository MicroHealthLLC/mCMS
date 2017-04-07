class CaseSupport < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :case_support_type, optional: true
  belongs_to :user
  belongs_to :case
  belongs_to :support_status, optional: true
  has_one :case_support_extend_demography

  has_many :case_support_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :case_support_attachments, reject_if: :all_blank, allow_destroy: true

  scope :not_show_in_search, ->{ where(not_show_in_search: false)}

  has_many :appointment_links, as: :linkable

  validates_presence_of :case_id, :user_id

  def extend_informations
    case_support_extend_demography || CaseSupportExtendDemography.new(case_support_id: self.id)
  end

  def self.enumeration_columns
    [
        ["#{CaseSupportType}", 'case_support_type_id'],
        ["#{SupportStatus}", 'support_status_id']
    ]
  end

  def to_s
    name
  end

  def removed?
    !status
  end

  def self.visible
    super.active
  end

  def self.active
    where(status: true)
  end



  def support_status
    if support_status_id
      super
    else
      SupportStatus.default
    end
  end

   def case_support_type
    if case_support_type_id
      super
    else
      CaseSupportType.default
    end
  end

  def self.safe_attributes
    [
        :first_name, :middle_name, :last_name, :case_id, :not_show_in_search,
        :note, :case_support_type_id, :user_id, :date_started, :date_ended, :support_status_id,
        case_support_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def name
    "#{first_name} #{middle_name} #{last_name}".tr('  ', ' ')
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Case Support  ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Case Support "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Started: ", " #{date_started}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Ended: ", " #{date_ended}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Support Status: ", " #{support_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Case Support Type: ", " #{case_support_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def for_mail
    output = ""
    output<< "<h2>Case Support ##{id} </h2>"
    output<< "<b>Name: </b> #{name}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end

end
