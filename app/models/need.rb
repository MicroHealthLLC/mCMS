class Need < ApplicationRecord
  belongs_to :user
  belongs_to :case, optional: true
  belongs_to :need_enum, optional: true
  belongs_to :priority_type, optional: true
  belongs_to :need_status, optional: true


  def self.safe_attributes
    [ :need_enum_id, :priority_type_id, :user_id, :need_status_id,
      :description, :date_completed, :date_due, :date_identified, :case_id
    ]
  end
  has_many :need_notes, foreign_key: :owner_id
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

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Need ##{id}", :style => :bold}

    pdf.text "<b>Need: </b> #{need_enum}", :inline_format =>  true
    pdf.text "<b>Description: </b> #{ActionView::Base.full_sanitizer.sanitize(description)}", :inline_format =>  true
    pdf.text "<b>Goal status: </b> #{need_status}", :inline_format =>  true
    pdf.text "<b>Priority: </b> #{priority_type}", :inline_format =>  true

    pdf.text "<b>Date due: </b> #{date_due}", :inline_format =>  true
    pdf.text "<b>Date completed: </b> #{date_completed}", :inline_format =>  true
    pdf.text "<b>Date completed: </b> #{date_identified}", :inline_format =>  true
  end

end
