class Contact < ApplicationRecord
  belongs_to :contact_type
  belongs_to :user
  belongs_to :contact_status, optional: true
  has_one :contact_extend_demography

  has_many :contact_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :contact_attachments, reject_if: :all_blank, allow_destroy: true

  scope :not_show_in_search, ->{ where(not_show_in_search: false)}

  after_save :send_notification
  def send_notification
    UserMailer.contact_notification(self).deliver_later unless self.not_show_in_search
  end


  def contact_type
    if contact_type_id
      super
    else
      ContactType.default
    end
  end


 def contact_status
    if contact_status_id
      super
    else
      ContactStatus.default
    end
  end


  def self.safe_attributes
    [:emergency_contact, :first_name, :middle_name, :last_name, :not_show_in_search, 
     :note, :contact_type_id, :user_id, :date_started , :date_ended , :contact_status_id,
     contact_attachments_attributes: [Attachment.safe_attributes]]
  end

  def extend_informations
    contact_extend_demography || ContactExtendDemography.new(contact_id: self.id)
  end

  def name
    "#{first_name} #{middle_name} #{last_name}".tr('  ', ' ')
  end

  def to_pdf(pdf)
    pdf.font_size(25){  pdf.text "Contact ##{id}", :style => :bold}
    user.to_pdf_brief_info(pdf)
    pdf.text "<b>Emergency contact: </b> #{emergency_contact}", :inline_format =>  true
    pdf.text "<b>Name: </b> #{name}", :inline_format =>  true
    pdf.text "<b>Note: </b> #{ActionView::Base.full_sanitizer.sanitize(note)}", :inline_format =>  true
  end

  def for_mail
    output = ""
    output<< "<h2>Contact ##{id} </h2>"
    output<< "<b>Emergency contact: </b> #{emergency_contact}<br/>"
    output<< "<b>Name: </b> #{name}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end



end
