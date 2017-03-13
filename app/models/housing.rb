class Housing < ApplicationRecord
  belongs_to :user
  belongs_to :housing_status, :optional=> true
  belongs_to :housing_type, :optional=> true
  belongs_to :cohabitation_type, :optional=> true
  belongs_to :primary_address, :optional=> true, class_name: 'Address'

  has_many :housing_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :housing_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id


  def self.enumeration_columns
    [
        ["#{HousingStatus}", 'housing_status_id'],
        ["#{CohabitationType}", 'cohabitation_type_id'],
        ["#{HousingType}", 'housing_type_id']
    ]
  end

  def housing_status
    if housing_status_id
      super
    else
      HousingStatus.default
    end
  end

  def housing_type
    if housing_type_id
      super
    else
      HousingType.default
    end
  end

  def cohabitation_type
    if cohabitation_type_id
      super
    else
      CohabitationType.default
    end
  end

  def to_s
    title
  end

  def self.safe_attributes
    [:user_id, :title, :housing_type_id, :cohabitation_type_id,
     :housing_status_id, :description,
     :primary_address_id, :estimated_monthly_payment,
     :date_start, :date_end,
     housing_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.table([[ "Housing ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) ; pdf.table([["Informations Data "]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Housing Type: ", " #{housing_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Housing Status: ", " #{housing_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Primary Address: ", " #{primary_address}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Cohabitation Type: ", " #{cohabitation_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Start date: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "End date: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
  
end
