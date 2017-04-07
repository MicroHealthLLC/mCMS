class Affiliation < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  has_many :users
  belongs_to :user
  belongs_to :affiliation_type
  belongs_to :affiliation_status, foreign_key: :status_id
  has_one :affiliation_extend_demography, :dependent => :destroy


  has_many :affiliation_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :affiliation_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name
  after_save :send_notification

  def send_notification
    UserMailer.affiliation_notification(self).deliver_later
  end

  def self.enumeration_columns
    [
        ["#{AffiliationType}", 'affiliation_type_id'],
        ["#{AffiliationStatus}", 'status_id']
    ]
  end

  def affiliation_status
    if status_id
      super
    else
      AffiliationStatus.default
    end
  end
  alias status affiliation_status

   def affiliation_type
    if affiliation_type_id
      super
    else
      AffiliationType.default
    end
  end

  def visible?
    User.current == user or User.current.allowed_to?(:edit_affiliations) or User.current.allowed_to?(:manage_affiliations)
  end

  def to_s
    name
  end

  def self.safe_attributes
    [:name, :affiliation_type_id, :note, :user_id, :status_id, :date_start, :date_end ]
  end

  def extend_informations
    affiliation_extend_demography || AffiliationExtendDemography.new(affiliation_id: self.id)
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Affiliation ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center}) }
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Affiliation "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Affiliation Type: ", " #{affiliation_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Affiliation Status: ", " #{affiliation_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date End: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def for_mail
    output = ""
    output<< "<h2>Affiliation ##{id} </h2>"
    output<< "<b>name: </b> #{name}<br/>"
    output<< "<b>Affiliation type: </b> #{affiliation_type}<br/>"
    output<< "<b>Affiliation Status: </b> #{affiliation_status}<br/>"
    output<< "<b>Date Start: </b> #{date_start}<br/>"
    output<< "<b>Date End: </b> #{date_end}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
