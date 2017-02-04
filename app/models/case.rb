class Case < ApplicationRecord
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
  has_many :enrollments, dependent: :destroy
  has_many :case_supports, dependent: :destroy
  has_many :teleconsults, dependent: :destroy

  has_many :watchers, class_name: 'CaseWatcher', dependent: :destroy

  has_many :case_notes, foreign_key: :owner_id, dependent: :destroy

  scope :root, -> {where(subcase_id: nil)}
  scope :subcases, -> {where.not(subcase_id: nil)}
  scope :not_private, -> {where(is_private: false)}

  default_scope -> {where(is_private: false).or(where(private_author_id: User.current.id)) }

  validates_presence_of :title
  before_create :check_private_author

  before_destroy do
    sub_cases.update_all(subcase_id: nil)
  end

  def self.include_enumerations
    includes(:case_type, :case_status_type, :case_category_type, :priority_type, :case_source).
        references(:case_type, :case_status_type, :case_category_type, :priority_type, :case_source)
  end

  # Enumeration Status
  def self.priority_type(status = nil)
    case status
      when 'closed' then where(priority_id: PriorityType.closed.pluck(:id) )
      when 'flagged' then where(priority_id: PriorityType.flagged.pluck(:id) )
      else
        where.not(priority_id: PriorityType.closed.or(PriorityType.flagged).pluck(:id) )
    end
  end

  def priority_type
    if priority_id
      super
    else
      PriorityType.default
    end
  end

  def self.case_category_type(status= nil)
    case status
      when 'closed' then where(case_category_id: CaseCategoryType.closed.pluck(:id) )
      when 'flagged' then where(case_category_id: CaseCategoryType.flagged.pluck(:id) )
      else
        where.not(case_category_id: CaseCategoryType.closed.or(CaseCategoryType.flagged).pluck(:id) )
    end
  end

  def case_category_type
    if case_category_id
      super
    else
      CaseCategoryType.default
    end
  end

  def self.case_status_type(status= nil)
    case status
      when 'closed' then where(case_status_type_id: CaseStatusType.closed.pluck(:id) )
      when 'flagged' then where(case_status_type_id: CaseStatusType.flagged.pluck(:id) )
      else
        where.not(case_status_type_id: CaseStatusType.closed.or(CaseStatusType.flagged).pluck(:id) )
    end
  end

  def case_source
    if case_source_id
      super
    else
      CaseSource.default
    end
  end

  def self.case_source(status= nil)
    case status
      when 'closed' then where(case_source_id: CaseSource.closed.pluck(:id) )
      when 'flagged' then where(case_source_id: CaseSource.flagged.pluck(:id) )
      else
        where.not(case_source_id: CaseSource.closed.or(CaseSource.flagged).pluck(:id) )
    end
  end

  def case_status_type
    if case_status_type_id
      super
    else
      CaseStatusType.default
    end
  end

  def self.case_type(status= nil)
    case status
      when 'closed' then where(case_type_id: CaseType.closed.pluck(:id) )
      when 'flagged' then where(case_type_id: CaseType.flagged.pluck(:id) )
      else
        where.not(case_type_id: CaseType.closed.or(CaseType.flagged).pluck(:id) )
    end
  end


  def case_type
    if case_type_id
      super
    else
      CaseType.default
    end
  end
  def self.all_data
    opened.or(Case.flagged)
  end

  def self.opened
    Case.priority_type.
        case_category_type.
        case_status_type.
        case_type.
        case_source
  end

  def self.closed
    Case.priority_type('closed').
        or(Case.case_category_type('closed')).
        or(Case.case_status_type('closed')).
        or(Case.case_source('closed')).
        or(Case.case_type('closed'))
  end

  def self.flagged
    Case.priority_type('flagged').
        or(Case.case_category_type('flagged')).
        or(Case.case_status_type('flagged')).
        or(Case.case_source('flagged')).
        or(Case.case_type('flagged'))
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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Case ##{id}", :style => :bold}

    pdf.text "<b>Title: </b> #{title}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Case type: </b> #{case_type}", :inline_format =>  true
    pdf.text "<b>Case status: </b> #{case_status_type}", :inline_format =>  true
    pdf.text "<b>Case category: </b> #{case_category_type}", :inline_format =>  true
    pdf.text "<b>Case Source: </b> #{case_source}", :inline_format =>  true
    pdf.text "<b>Priority: </b> #{priority_type}", :inline_format =>  true

    pdf.text "<b>Date start: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>Date due: </b> #{date_due}", :inline_format =>  true
    pdf.text "<b>Date completed: </b> #{date_completed}", :inline_format =>  true

    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

end
