class ClientJournal < ApplicationRecord
  belongs_to :user
  belongs_to :client_journal_type, optional: true

  has_many :client_journal_notes, foreign_key: :owner_id

  has_many :client_journal_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :client_journal_attachments, reject_if: :all_blank, allow_destroy: true

  before_save do
    self.date = Time.now if self.date.blank?
  end

  validates_presence_of :title, :user_id

  def self.safe_attributes
    [:user_id, :note, :title, :date, :client_journal_type_id,
     client_journal_attachments_attributes: [Attachment.safe_attributes]]
  end

  def self.enumeration_columns
    [
        ["#{ClientJournalType}", 'client_journal_type_id']
    ]
  end

  def client_journal_type
    if client_journal_type_id
      super
    else
      ClientJournalType.default
    end
  end

  def to_s
    title
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Client Journal ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Client Journal"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Client Journal Type: ", " #{client_journal_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "date: ", " #{date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end
end
