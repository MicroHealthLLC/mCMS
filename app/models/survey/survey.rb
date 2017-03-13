class Survey::Survey < ApplicationRecord

  self.table_name = "survey_surveys"

  acceptable_attributes :name, :description,
                        :finished,
                        :active,
                        :attempts_number,
                        :survey_type_id,
                        :questions_attributes => Survey::Question::AccessibleAttributes

  # relations
  has_many :attempts,  :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :survey_users,  :dependent => :destroy
  has_many :survey_notes, foreign_key: :owner_id, :dependent => :destroy
  has_many :survey_cases, :dependent => :destroy

  belongs_to :survey_type, optional: true

  belongs_to :case, optional: true, foreign_key: :related_to_id

  accepts_nested_attributes_for :questions,
                                :reject_if => ->(q) { q[:text].blank? },
                                :allow_destroy => true

  # scopes
  scope :active,   -> { where(:active => true) }
  scope :inactive, -> { where(:active => false) }
  scope :not_related, -> {where(related_to_id: nil)}


  # validations
  validates :attempts_number, :numericality => { :only_integer => true, :greater_than => -1 }
  validates :description, :name, :presence => true, :allow_blank => false
  validate  :check_active_requirements


  def case
    survey_cases.where(assigned_to_id: Case.visible.pluck(:id)).map(&:case).flatten
  end

  def to_s
    name
  end

  def survey_type
    if survey_type_id
      super
    else
      SurveyType.default
    end
  end
  # returns all the correct options for current surveys
  def correct_options
    return self.questions.map(&:correct_options).flatten
  end

  # returns all the incorrect options for current surveys
  def incorrect_options
    return self.questions.map(&:incorrect_options).flatten
  end

  def available_for_participant?(participant)
    upper_bound = self.attempts_number
    current_number_of_attempts = participant ? self.attempts.for_participant(participant).size : upper_bound

    return !((current_number_of_attempts >= upper_bound) && (upper_bound != 0))
  end

  def avaliable_for_participant?(participant)
    warn "[DEPRECATION] avaliable_for_participant? is deprecated. Please use available_for_participant? instead"
    available_for_participant?(participant)
  end

  def to_pdf(pdf, show_user = true)
    pdf.font_size(25){  pdf.table([[ "Survey ##{id}"]], :row_colors => ['#D999FF'], :column_widths => [ 523], :cell_style=> {align: :center})}
    pdf.table([[ "name: ", " #{name}"]], :column_widths => [ 150, 373])
    pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
    self.questions.each_with_index do |question, index|
      pdf.table([[ "Q#{index+1}: ", ""]], :column_widths => [ 150, 373])
      pdf.table([[ "#{question.text}: ", ""]], :column_widths => [ 150, 373])
      question.options.each do |option|
        pdf.table([[ "-#{option.text}: ", ""]], :column_widths => [ 150, 373])
      end
    end
  end

  private

  # a surveys only can be activated if has one or more questions
  def check_active_requirements
    errors.add(:active, "Survey without questions cannot be activated") if self.active && self.questions.empty?
  end
end
