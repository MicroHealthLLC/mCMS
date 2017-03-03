class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :assigned_to, optional: true, class_name: 'User'
  belongs_to :priority_type, optional: true
  belongs_to :goal_status, optional: true

  has_many :need_goals, dependent: :destroy
  has_many :needs, through: :need_goals

  has_many :appointment_links, as: :linkable

  accepts_nested_attributes_for :need_goals, reject_if: :all_blank, allow_destroy: true


  has_many :goal_plans, dependent: :destroy
  has_many :plans, through: :goal_plans

  has_many :goal_notes, foreign_key: :owner_id, dependent: :destroy

  validates_presence_of :name
  def self.safe_attributes
    [
        :priority_type_id, :user_id, :goal_status_id, :name, :assigned_to_id,
        :description, :date_completed, :date_due, :date_start,  :case_id,
        need_goals_attributes: [NeedGoal.safe_attributes]
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
        ["#{GoalStatus}", 'goal_status_id']
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

  def to_s
    name
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Goal ##{id}", :style => :bold}

    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Goal status: </b> #{goal_status}", :inline_format =>  true
    pdf.text "<b>Priority: </b> #{priority_type}", :inline_format =>  true

    pdf.text "<b>Date start: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>Date due: </b> #{date_due}", :inline_format =>  true
    pdf.text "<b>Date completed: </b> #{date_completed}", :inline_format =>  true
  end

end
