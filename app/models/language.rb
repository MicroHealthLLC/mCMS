class Language < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user

  belongs_to :language_status, foreign_key: :status_id
  belongs_to :proficiency_type, foreign_key: :proficiency_id

  has_many :language_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :language_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id
  before_validation do
    if self.snomed.blank?
      errors[:base] << "Language cannot be blank"
    end
  end

  def self.enumeration_columns
    [
        ["#{LanguageType}", 'language_type_id'],
        ["#{ProficiencyType}", 'proficiency_id'],
        ["#{LanguageStatus}", 'status_id']
    ]
  end

  def language_type
    snomed
  end

  def self.include_enumerations
    includes(:language_status, :proficiency_type).
        references(:language_status, :proficiency_type)
  end

  def self.csv_attributes
    [
        I18n.t('language_type'),
        I18n.t('language_status'),
        I18n.t('proficiency'),
        I18n.t('label_date'),
    ]
  end


  def language_status
    if status_id
      super
    else
      LanguageStatus.default
    end
 end
  alias status language_status

  def proficiency_type
    if proficiency_id
      super
    else
      ProficiencyType.default
    end
  end
  alias proficiency proficiency_type

  def visible?
    User.current.permitted_users.include? user
  end

  def self.safe_attributes
    [:user_id, :note, :language_type_id, :proficiency_id, :status_id, :snomed,
     language_attachments_attributes: [Attachment.safe_attributes]]
  end

  def to_s
    language_type
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Language ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
    user.to_pdf_brief_info(pdf) if show_user
    pdf.table([[" Language "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})
    pdf.table([[ "Language type: ", " #{language_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Language Status: ", " #{language_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Proficiency: ", " #{proficiency_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end

  def can_send_email?
    true
  end

  def for_mail
    output = ""
    output<< "<h2>Language ##{id} </h2>"
    output<< "<b>Language type: </b> #{language_type}<br/>"
    output<< "<b>Language Status: </b> #{language_status}<br/>"
    output<< "<b>Proficiency: </b> #{proficiency_type}<br/>"
    output<< "<b>Note: </b> #{note}<br/>"

    output.html_safe
  end

end
