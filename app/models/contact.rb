class Contact < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :contact_type
  belongs_to :user
  belongs_to :contact_status, optional: true
  belongs_to :gender_type, foreign_key: :gender_id, optional: true
  has_one :contact_extend_demography

  validates_presence_of :user_id, :first_name, :last_name

  has_many :contact_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :contact_attachments, reject_if: :all_blank, allow_destroy: true

  scope :not_show_in_search, ->{ where(not_show_in_search: false)}

  def self.include_enumerations
    includes(:contact_status, :contact_type).
        references(:contact_status, :contact_type)
  end

  def self.csv_attributes
    [
    I18n.t('label_name') ,
    I18n.t('emergency_contact') ,
    I18n.t('relationship') ,

    I18n.t('enumeration_contact_status') ,
    I18n.t('language') ,
    I18n.t('date_started') ,
    I18n.t('date_end')
    ]
  end
  
  
  def self.visible
    super.active
  end

  def self.active
    where(status: true)
  end

  def gender_type
    if gender_id
      super
    else
      GenderType.default
    end
  end
  alias gender gender_type

  def self.enumeration_columns
    [
        ["#{ContactStatus}", 'contact_status_id'],
        ["#{ContactType}", 'contact_type_id']
    ]
  end

  def removed?
    !status
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

  def phone
    return Phone.new if contact_extend_demography.nil?
    phones = contact_extend_demography.phones.select{|p| p.phone_number.present?}
    phones.first || Phone.new
  end



  def self.safe_attributes
    [:emergency_contact, :first_name, :middle_name, :last_name, :not_show_in_search,
     :note, :contact_type_id, :user_id, :language, :birthday, :gender,
     :date_started , :date_ended , :contact_status_id,
     contact_attachments_attributes: [Attachment.safe_attributes]]
  end

  def extend_informations
    contact_extend_demography || ContactExtendDemography.new(contact_id: self.id)
  end

  def to_s
    name
  end

  def name
    "#{first_name} #{middle_name} #{last_name}".tr('  ', ' ')
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Contact ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([["Contact"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Emergency contact: ", " #{emergency_contact}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Language: ", " #{language}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Birthday: ", " #{birthday}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Gender: ", " #{gender}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Contact ##{id} </h2>"
    output<< "<b>Emergency contact: </b> #{emergency_contact}<br/>"
    output<< "<b>Language: </b> #{language}<br/>"
    output<< "<b>Name: </b> #{name}<br/>"
    output<< "<b>Birthday: </b> #{birthday}<br/>"
    output<< "<b>Gender: </b> #{gender}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"
    output.html_safe
  end



end
