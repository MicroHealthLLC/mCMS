class ClientJournal < ApplicationRecord
  belongs_to :user
  belongs_to :client_journal_type, optional: true

  has_many :client_journal_notes, foreign_key: :owner_id

  has_many :client_journal_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :client_journal_attachments, reject_if: :all_blank, allow_destroy: true

  before_save do
    self.date = Time.now if self.date.blank?
  end

  validates_presence_of :title, :user_id

  def self.safe_attributes
    [:user_id, :note, :title, :date, :client_journal_type_id,
     client_journal_attachments_attributes: [Attachment.safe_attributes]]
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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Client Journal ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Client Journal Type: </b> #{client_journal_type}", :inline_format =>  true
    pdf.text "<b>date: </b> #{date}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end
end
