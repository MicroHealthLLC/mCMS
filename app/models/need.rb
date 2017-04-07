class Need < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :assigned_to, optional: true, class_name: 'User'
  belongs_to :need_enum, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :need_status, optional: true

  has_many :appointment_links, as: :linkable

  has_many :need_goals,  dependent: :destroy
  has_many :goals, through: :need_goals

  has_many :need_notes, foreign_key: :owner_id, dependent: :destroy

  def self.safe_attributes
    [ :need_enum_id, :priority_type_id, :user_id, :need_status_id, :assigned_to_id, :percent_done,
      :description, :date_completed, :date_due, :date_identified, :case_id
    ]
  end

  def available_goals
    self.case.try(:goals) || []
  end

  def self.enumeration_columns
    [
        ["#{PriorityType}", 'priority_type_id'],
        ["#{NeedEnum}", 'need_enum_id'],
        ["#{NeedStatus}", 'need_status_id']
    ]
  end

  def need_enum
    if need_enum_id
      super
    else
      NeedEnum.default
    end
  end

  def priority_type
    if priority_type_id
      super
    else
      PriorityType.default
    end
  end

  def need_status
    if need_status_id
      super
    else
      NeedStatus.default
    end
  end

  def to_s
    need_enum
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Need ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Need "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

    pdf.table([[ "Need: ", " #{need_enum}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Need status: ", " #{need_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Percent Done ", " #{percent_done} %"]], :column_widths => [ 150, 373])
    pdf.table([[ "Priority: ", " #{priority_type}"]], :column_widths => [ 150, 373])

    pdf.table([[ "Date due: ", " #{date_due}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date completed: ", " #{date_completed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date completed: ", " #{date_identified}"]], :column_widths => [ 150, 373])
  end

end
