class Goal < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :assigned_to, optional: true, class_name: 'User'
  belongs_to :priority_type, optional: true
  belongs_to :goal_status, optional: true
  belongs_to :goal_type, optional: true
  validates_presence_of :user_id, :name
  has_many :need_goals, dependent: :destroy
  has_many :needs, through: :need_goals

  has_many :appointment_links, as: :linkable

  accepts_nested_attributes_for :need_goals, reject_if: :all_blank, allow_destroy: true


  has_many :goal_plans, dependent: :destroy
  has_many :plans, through: :goal_plans

  has_many :goal_notes, foreign_key: :owner_id, dependent: :destroy

  after_save :update_percent_done

  def update_percent_done
   # GoalNeedWorker.perform_in(1.second, self.id)
    needs.each do |need|
      need.update_attributes(percent_done: need.goals.average(:percent_done).to_i)
    end
  end

  validates_presence_of :name
  def self.safe_attributes
    [
        :priority_type_id, :user_id, :goal_status_id, :name, :assigned_to_id, :percent_done,
        :description, :date_completed, :date_due, :date_start,  :case_id, :goal_type_id,
        need_goals_attributes: [NeedGoal.safe_attributes]
    ]
  end

  def self.include_enumerations
    includes(:user, :case, :priority_type, :goal_status, :goal_type).
        references(:user, :case, :priority_type, :goal_status, :goal_type)
  end

  def self.csv_attributes
    [
        I18n.t('client'),
        I18n.t('goal') ,
        I18n.t('case') ,
        I18n.t('priority') ,
        I18n.t('goal_status') ,
        I18n.t('goal_type') ,
        'Percent Done',
        I18n.t('date_start') ,
        I18n.t('date_due') ,
        I18n.t('date_completed')
    ]
  end

  def available_plans
    self.case.try(:plans) || []
  end

  def available_needs
    self.case.try(:needs) || []
  end

  def self.enumeration_columns
    [
        ["#{PriorityType}", 'priority_type_id'],
        ["#{GoalStatus}", 'goal_status_id'],
        ["#{GoalType}", 'goal_type_id']
    ]
  end

  def priority_type
    if priority_type_id
      super
    else
      PriorityType.default
    end
  end

  def goal_status
    if goal_status_id
      super
    else
      GoalStatus.default
    end
  end

 def goal_type
    if goal_type_id
      super
    else
      GoalType.default
    end
  end

  def to_s
    name
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Goal ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}

    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Goal "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Name ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Goal status ", " #{goal_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Goal Type ", " #{goal_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Percent Done ", " #{percent_done} %"]], :column_widths => [ 150, 373])
    pdf.table([[ "Priority ", " #{priority_type}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Date start ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date due ", " #{date_due}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date completed ", " #{date_completed}"]], :column_widths => [ 150, 373])
  end

  def little_description
    output = 'Goal'
    output<< "<p>Status #{goal_status} </p>"
    output<< "<p>Type #{goal_type} </p>"
    output<< "<p> Priority: #{priority_type} </p>"
    output<< "<p> Percent Done: #{percent_done} % </p>"

    output.html_safe
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Goal ##{id} </h2><br/>"
    output<<"<b>Name : </b> #{name}<br/>"
    output<<"<b>Goal Status : </b> #{goal_status}<br/>"
    output<<"<b>Goal Type : </b> #{goal_type}<br/>"
    output<<"<b>Percent Done: </b> #{percent_done}%<br/>"
    output<<"<b>Priority: </b> #{priority_type}<br/>"
    output<<"<b>Date start : </b> #{date_start}<br/>"
    output<<"<b>Date due : </b> #{date_due}<br/>"
    output<<"<b>Date completed : </b> #{date_completed}<br/>"
    output<<"<b>Description: </b> #{description} <br/>"
    output.html_safe
  end

end
