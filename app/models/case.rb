class Case < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :assigned_to, class_name: 'User', optional: true
  belongs_to :user, optional: true
  belongs_to :private_author, class_name: 'User', foreign_key: :private_author_id, optional: true
  belongs_to :priority_type, optional: true, foreign_key: :priority_id
  belongs_to :case_type, optional: true
  belongs_to :case_category_type, optional: true, foreign_key: :case_category_id
  belongs_to :case_status_type, optional: true
  belongs_to :case_source, optional: true


  belongs_to :case, optional: true, foreign_key: :subcase_id

  has_many :sub_cases, foreign_key: :subcase_id, class_name: 'Case', dependent: :destroy
  has_many :relations, foreign_key: :case_id, class_name: 'CaseRelation', dependent: :destroy


  has_many :tasks, foreign_key: :related_to_id, class_name: 'Task', dependent: :destroy
  has_many :survey_cases, foreign_key: :assigned_to_id, dependent: :destroy
  has_many :documents, foreign_key: :related_to_id, class_name: 'Document', dependent: :destroy
  has_many :checklists, foreign_key: :assigned_to_id, class_name: 'ChecklistCase', dependent: :destroy
  has_many :appointments, foreign_key: :related_to_id, class_name: 'Appointment', dependent: :destroy
  has_many :needs, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :referrals, dependent: :destroy
  has_many :jsignatures, as: :signature_owner, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :worker_compensations, dependent: :destroy
  has_many :job_apps, dependent: :destroy
  has_many :case_supports, dependent: :destroy
  has_many :teleconsults, dependent: :destroy
  has_many :case_organizations, dependent: :destroy
  has_many :measurement_records, dependent: :destroy
  has_many :transports, dependent: :destroy
  has_many :organizations, through: :case_organizations

  has_many :watchers, class_name: 'CaseWatcher', dependent: :destroy

  has_many :case_notes, foreign_key: :owner_id, dependent: :destroy

  scope :root, -> {where(subcase_id: nil)}
  scope :subcases, -> {where.not(subcase_id: nil)}
  scope :not_private, -> {where(is_private: false)}

  default_scope -> {where(is_private: false).or(where(private_author_id: User.current.id)) }

  validates_presence_of :title
  before_validation do
    if self.date_due.present? and self.date_start.present? and self.date_start > self.date_due
      errors[:base] << "Due date cannot be ealer than start date"
    end
  end

  before_create :check_private_author

  before_destroy do
    sub_cases.update_all(subcase_id: nil)
  end

  def self.include_enumerations
    includes(:case_type, :case_status_type, :case_category_type, :priority_type, :case_source).
        references(:case_type, :case_status_type, :case_category_type, :priority_type, :case_source)
  end

  def little_description
    output = 'Case'
    output<< "<p> #{case_type} </p>"
    output<< "<p> #{date_start} </p>"
    output<< "<p> #{date_due} </p>"

    output.html_safe
  end

  def self.csv_attributes
    ['Client', 'Title', 'Priority',
     'Type', 'Status', 'Category',
     'Case Source', 'Date start',
     'Date end']
  end


  def priority_type
    if priority_id
      super
    else
      PriorityType.default
    end
  end

  def case_category_type
    if case_category_id
      super
    else
      CaseCategoryType.default
    end
  end

  def case_source
    if case_source_id
      super
    else
      CaseSource.default
    end
  end

  def case_status_type
    if case_status_type_id
      super
    else
      CaseStatusType.default
    end
  end

  def case_type
    if case_type_id
      super
    else
      CaseType.default
    end
  end

  def self.enumeration_columns
    [
        ["#{CaseType}", 'case_type_id'],
        ["#{CaseSource}", 'case_source_id'],
        ["#{PriorityType}", 'priority_id'],
        ["#{CaseStatusType}", 'case_status_type_id'],
        ["#{CaseCategoryType}", 'case_category_id']
    ]
  end

  def surveys
    survey_cases
  end

  def visible
    where('assigned_to_id= :user OR user_id= :user', user: User.current.id )
  end

  def check_private_author
    if self.is_private
      self.private_author_id = User.current.id
    end
  end


  def redirection
    subcase_id ? Case.find(subcase_id) : self
  end

  def to_s
    title
  end


  def self.safe_attributes
    [
        :title, :description, :case_type_id, :is_private, :case_source_id, :private_author_id, :assigned_to_id, :priority_id, :subcase_id,
        :date_start, :date_due, :case_status_type_id, :date_completed, :case_status_id, :note, :case_category_id
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Case ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Case "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Case type: ", " #{case_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Case status: ", " #{case_status_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Case category: ", " #{case_category_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Case Source: ", " #{case_source}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Priority: ", " #{priority_type}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date due: ", " #{date_due}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date completed: ", " #{date_completed}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Case ##{id} </h2><br/>"
    output<<"<b>Title : </b> #{title}<br/>"
    output<<"<b>Case Type : </b> #{case_type}<br/>"
    output<<"<b>Case Status : </b> #{case_status_type}<br/>"
    output<<"<b>Case Category : </b> #{case_category_type}<br/>"
    output<<"<b>Case Source : </b> #{case_source}<br/>"
    output<<"<b>Priority : </b> #{priority_type}<br/>"
    output<<"<b>date start : </b> #{date_start}<br/>"
    output<<"<b>date due : </b> #{date_due}<br/>"
    output<<"<b>date Completed : </b> #{date_completed}<br/>"
    output<<"<b>Note: </b> #{note} <br/>"
    output.html_safe
  end


end
