class DailyLiving < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user

  belongs_to :daily_living_status, :optional=> true
  belongs_to :daily_living_type, :optional=> true
  validates_presence_of :user_id

  has_many :daily_living_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :daily_living_attachments, reject_if: :all_blank, allow_destroy: true

  def self.enumeration_columns
    [
        ["#{DailyLivingStatus}", 'daily_living_status_id']
    ]
  end



  def self.include_enumerations
    includes(:daily_living_type, :daily_living_status).
        references(:daily_living_type, :daily_living_status)
  end

  def self.csv_attributes
    [

        'Daily living Type',
        'Daily living status',
        'Date start',
        'Date end'
    ]
  end

  def daily_living_status
    if daily_living_status_id
      super
    else
      DailyLivingStatus.default
    end
  end

  def daily_living_type
    if daily_living_type_id
      super
    else
      DailyLivingType.default
    end
  end

  def to_s
    snomed
  end

  def self.safe_attributes
    [:title, :user_id, :daily_living_type_id, :snomed,
     :daily_living_status_id, :description,
     :date_start, :date_end,
     daily_living_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Daily living ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Daily Living "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Snomed: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Status: ", " #{daily_living_status}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Daily Living ##{id} </h2><br/>"
    output<<"<b>Snomed : </b> #{snomed}<br/>"
    output<<"<b>Status : </b> #{daily_living_status}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end


end
