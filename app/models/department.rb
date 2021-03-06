class Department < ApplicationRecord
  belongs_to :user
  belongs_to :department_type
  belongs_to :organization, optional: true


  has_one :department_extend_demography
  has_many :department_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :department_attachments, reject_if: :all_blank, allow_destroy: true

  def department_type
    if department_type_id
      super
    else
      DepartmentType.default
    end
  end

  before_destroy :check_integrity

  validates_presence_of :department_type_id
  validates_uniqueness_of :department_type_id

  def self.safe_attributes
    [:user_id, :note, :date_start, :date_end, :department_type_id,
     :organization_id, department_attachments_attributes: [Attachment.safe_attributes]]
  end

  def visible?
    User.current == user or User.current.allowed_to?(:edit_departments) or User.current.allowed_to?(:manage_departments)
  end

  def department_informations
    department_extend_demography || DepartmentExtendDemography.create(department_id: self.id)
  end

  def in_use?
    job_details.present?
  end

  alias :destroy_without_reassign :destroy
  # Destroy the enumeration
  # If a department is specified, objects are reassigned
  def destroy(reassign_to = nil)
    if reassign_to && reassign_to.is_a?(Department)
      self.transfer_relations(reassign_to)
    end
    destroy_without_reassign
  end

  def objects
    JobDetail.where(:department_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:department_id => to.id)
  end

  def check_integrity
    raise "Cannot delete enumeration" if self.in_use?
  end

  def users
    job_details.map{|job| job.user}
  end

  def to_s
    "#{department_type}"
  end

  def name
    "#{id} #{department_type}"
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Department ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "Department type: ", " #{department_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Organization: ", " #{organization}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date received: ", " #{date_start}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Date expired: ", " #{date_end}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

end
