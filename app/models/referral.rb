class Referral < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  belongs_to :case
  belongs_to :referral_type, optional: true
  belongs_to :referral_status, optional: true
  belongs_to :referred_by, class_name: 'User', optional: true
  belongs_to :referred_to, class_name: 'ClientOrganization', optional: true

  has_many :referral_relation_children, class_name: 'ReferralRelation', foreign_key: :referral_child_id
  has_many :referral_parents, class_name: 'Referral', through: :referral_relation_children

  has_many :referral_relation_parents, class_name: 'ReferralRelation', foreign_key: :referral_parent_id
  has_many :referral_children, class_name: 'Referral', through: :referral_relation_parents


  has_many :referral_notes, foreign_key: :owner_id, dependent: :destroy
  has_many :referral_results, dependent: :destroy

  has_many :referral_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :referral_attachments, reject_if: :all_blank, allow_destroy: true
  has_many :appointment_links, as: :linkable
  
  validates_presence_of :user_id, :title

  def self.enumeration_columns
    [
        ["#{ReferralType}", 'referral_type_id'],
        ["#{ReferralStatus}", 'referral_status_id']
    ]
  end

  def referral_type
    if referral_type_id
      super
    else
      ReferralType.default
    end
  end

  def referral_status
    if referral_status_id
      super
    else
      ReferralStatus.default
    end
  end

  def available_referrals
    (self.case.try(:referrals) || []) - [self] - [referral_parents]
  end

  def to_s
    title
  end

  def self.safe_attributes
    [
        :user_id, :title, :referral_type_id, :referral_date, :referral_appointment, :case_id,
        :referral_status_id, :referred_by_id, :referred_to_id, :referral_reason,
        referral_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Referral ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Referral "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Title: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referral Type: ", " #{referral_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referral Status: ", " #{referral_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referral date: ", " #{referral_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referral appointment: ", " #{referral_appointment}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referred By: ", " #{referred_by}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Referred To: ", " #{referred_to.to_s}"]], :column_widths => [ 150, 373])
    pdf.table([[ "description: ", " #{ActionView::Base.full_sanitizer.sanitize(referral_reason)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Referral ##{id} </h2>"
    output<<"<b>Title: </b> #{title}<br/>"
    output<<"<b>Referral Type: </b> #{referral_type}<br/>"
    output<<"<b>Referral Status: </b> #{referral_status}<br/>"
    output<<"<b>Referral date: </b> #{referral_date}<br/>"
    output<<"<b>Referral Appointment: </b> #{referral_appointment}<br/>"
    output<<"<b>Referred By: </b> #{referred_by}<br/>"
    output<<"<b>Referred To: </b> #{referred_to}<br/>"
    output<<"<b>Description: </b> #{description}<br/>"

    output.html_safe
  end
  
end
