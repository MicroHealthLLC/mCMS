class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :plan_status, optional: true
  validates_presence_of :name
  has_many :plan_notes, foreign_key: :owner_id

  has_many :goal_plans
  has_many :goals, through: :goal_plans

  def self.safe_attributes
    [
        :priority_type_id, :user_id, :plan_status_id, :name,
        :description, :date_completed, :date_due, :date_start,  :case_id
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

  def to_s
    name
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Plan ##{id}", :style => :bold}

    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Goal status: </b> #{plan_status}", :inline_format =>  true
    pdf.text "<b>Priority: </b> #{priority_type}", :inline_format =>  true

    pdf.text "<b>Date start: </b> #{date_start}", :inline_format =>  true
    pdf.text "<b>Date due: </b> #{date_due}", :inline_format =>  true
    pdf.text "<b>Date completed: </b> #{date_completed}", :inline_format =>  true
  end

end
