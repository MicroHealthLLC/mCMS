class CoreDemographic < ApplicationRecord
  belongs_to :user
  belongs_to :religion_type, foreign_key: :religion_id, optional: true
  belongs_to :gender_type, foreign_key: :gender_id, optional: true
  belongs_to :citizenship_type, optional: true
  belongs_to :marital_status, optional: true
  belongs_to :ethnicity_type, foreign_key: :ethnicity_id, optional: true

  after_save do
    user.touch
  end
  # validates_presence_of :user

  def religion_type
    if religion_id
      super
    else
      ReligionType.default
    end
  end

  def marital_status
    if marital_status_id
      super
    else
      MaritalStatus.default
    end
  end


  def gender_type
    if gender_id
      super
    else
      GenderType.default
    end
  end

  def citizenship_type
    if citizenship_type_id
      super
    else
      CitizenshipType.default
    end
  end

  def ethnicity_type
    if ethnicity_id
      super
    else
      EthnicityType.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :first_name, :last_name, :middle_name,
        :gender_id, :title, :marital_status_id,
        :birth_date, :religion_id,
        :note, :ethnicity_id, :citizenship_type_id
    ]
  end

  def gender
    gender_type
  end

  def to_pdf(pdf, show_user = true)
    pdf.table([[ "First name: ", " #{first_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Middle name: ", " #{middle_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Last name: ", " #{last_name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Gender: ", " #{gender_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Birthday: ", " #{birth_date}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Religion: ", " #{religion_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Marital Status: ", " #{marital_status}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Tile: ", " #{title}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Ethnicity: ", " #{ethnicity_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Citizenship: ", " #{citizenship_type}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Note: ", " #{ActionView::Base.full_sanitizer.sanitize(note)}"]], :column_widths => [ 150, 373])
  end
end
