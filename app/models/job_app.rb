class JobApp < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :app_state, optional: true
  belongs_to :occupation, optional: true

  validates_presence_of :user_id, :title

  has_many :job_app_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :job_app_attachments, reject_if: :all_blank, allow_destroy: true

  has_many :job_app_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :jobs

  def self.safe_attributes
    [:title, :occupation_id, :description, :app_state_id,
     :user_id, job_app_attachments_attributes: [Attachment.safe_attributes]]
  end

  def self.enumeration_columns
    [
        ["#{AppState}", 'app_state_id']
    ]
  end

  def app_state
    if app_state_id
      super
    else
      AppState.default
    end
  end

  def to_s
    title
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Job Application ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Job Application "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Application state: ", " #{app_state.to_s}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    jobs.each do |job|
      job.to_pdf(pdf)
    end
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Job Application ##{id} </h2><br/>"
    output<<"<b>Title : </b> #{title}<br/>"
    output<<"<b>Occupation : </b> #{occupation}<br/>"
    output<<"<b>Application state : </b> #{app_state}<br/>"
    output<<"<b>Description : </b> #{description.html_safe}<br/>"
    output.html_safe
  end

end
