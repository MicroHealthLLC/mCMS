class Plan < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :assigned_to, optional: true, class_name: 'User'
  belongs_to :priority_type, optional: true
  belongs_to :plan_status, optional: true
  belongs_to :plan_type, optional: true
  validates_presence_of :name, :user_id
  has_many :plan_notes, foreign_key: :owner_id, dependent: :destroy

  has_many :goal_plans, dependent: :destroy
  has_many :goals, through: :goal_plans
  accepts_nested_attributes_for :goal_plans, reject_if: :all_blank, allow_destroy: true

  has_many :plan_tasks, dependent: :destroy
  has_many :measurement_records, dependent: :destroy
  has_many :tasks, through: :plan_tasks
  has_many :appointment_links, as: :linkable

  after_save :update_percent_done
  before_validation do
    if self.date_due.present? and self.date_start.present? and self.date_start > self.date_due
      errors[:base] << "Due date cannot be earlier than start date"
    end
    if self.date_completed.present? and self.date_start.present? and self.date_start > self.date_completed
      errors[:base] << "Completed date cannot be earlier than start date"
    end
  end

  def update_percent_done
    # PlanGoalWorker.perform_in(1.second, self.id)
    goals.each do |goal|
      goal.update_attributes percent_done: goal.plans.average(:percent_done).to_i
    end
  end

  def self.safe_attributes
    [
        :priority_type_id, :user_id, :plan_status_id, :name, :assigned_to_id, :percent_done,
        :description, :date_completed, :date_due, :date_start,  :case_id, :plan_type_id,
        goal_plans_attributes: [GoalPlan.safe_attributes]
    ]
  end

  def self.include_enumerations
    includes(:user, :case, :priority_type, :plan_status, :plan_type).
        references(:user, :case, :priority_type, :plan_status, :plan_type)
  end

  def self.csv_attributes
    [
        I18n.t('client'),
        I18n.t('plan') ,
        I18n.t('case') ,
        I18n.t('priority') ,
        I18n.t('plan_status') ,
        I18n.t('plan_type') ,
        'Percent Done',
        I18n.t('date_start') ,
        I18n.t('date_due') ,
        I18n.t('date_completed') ,

    ]
  end

  def available_tasks
    self.case.try(:tasks) || []
  end

  def available_goals
    self.case.try(:goals) || []
  end

  def self.enumeration_columns
    [
        ["#{PriorityType}", 'priority_type_id'],
        ["#{PlanStatus}", 'plan_status_id'],
        ["#{PlanType}", 'plan_type_id']
    ]
  end

  def priority_type
    if priority_type_id
      super
    else
      PriorityType.default
    end
  end

  def plan_status
    if plan_status_id
      super
    else
      PlanStatus.default
    end
  end

  def plan_type
    if plan_type_id
      super
    else
      PlanType.default
    end
  end

  def to_s
    name
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Plan ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Plan "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Plan status: ", " #{plan_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Plan type: ", " #{plan_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Percent Done ", " #{percent_done} %"]], :column_widths => [ 150, 373])
    pdf.table([[ "Priority: ", " #{priority_type}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Date start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date due: ", " #{date_due}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date completed: ", " #{date_completed}"]], :column_widths => [ 150, 373])
  end

  def little_description
    output = 'Plan'
    output<< "<p> Status #{plan_status} </p>"
    output<< "<p> Type #{plan_type} </p>"
    output<< "<p> Priority:  #{priority_type} </p>"
    output<< "<p> Percent done: #{percent_done}% </p>"

    output.html_safe
  end


  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Plan ##{id} </h2><br/>"
    output<<"<b>Name: </b> #{name}<br/>"
    output<<"<b>Plan Status : </b> #{plan_status}<br/>"
    output<<"<b>Plan Type : </b> #{plan_type}<br/>"
    output<<"<b>Percent Done : </b> #{percent_done} %<br/>"
    output<<"<b>Priority : </b> #{priority_type}<br/>"
    output<<"<b>Date start: </b> #{date_start}<br/>"
    output<<"<b>Date due: </b> #{date_due}<br/>"
    output<<"<b>Date Completed: </b> #{date_completed}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
