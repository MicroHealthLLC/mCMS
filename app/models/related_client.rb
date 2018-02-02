class RelatedClient < ApplicationRecord
  belongs_to :user
  belongs_to :relationship, optional: true, class_name: 'ContactType'
  belongs_to :related_client, class_name: 'User'

  validates_presence_of :user_id, :related_client_id
  before_validation do
    if self.date_end.present? and self.date_start.present? and self.date_start > self.date_end
      errors[:base] << "End date cannot be earlier than start date"
    end
  end

  def self.include_enumerations
    includes(:related_client).
        references(:related_client)
  end

  def self.csv_attributes
    [
    'Related client',
    'Relationship',
    'Date start',
    'Date end',
    ]
  end
  
  def to_s
    related_client
  end

  def relationship
    if relationship_id
      super
    else
      ContactType.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :related_client_id, :snomed,
        :date_start, :date_end, :description
    ]
  end

  def to_pdf(pdf)
    pdf.table([[" Related client ##{id} "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Related Client: ", " #{related_client}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Relationship: ", " #{snomed}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date Start: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date End: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
  end
end
