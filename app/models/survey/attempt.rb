class Survey::Attempt < ApplicationRecord

  self.table_name = "survey_attempts"

  acceptable_attributes :winner, :survey, :survey_id,
    :participant,
    :participant_id,
    :answers_attributes => ::Survey::Answer::AccessibleAttributes

  # relations
  belongs_to :survey
  belongs_to :participant, :polymorphic => true
  has_many :answers, :dependent => :destroy
  has_many :attempt_notes, foreign_key: :owner_id
  accepts_nested_attributes_for :answers,
    :reject_if => ->(q) { q[:question_id].blank? || q[:option_id].blank? }

  # validations
  validates :participant_id, :participant_type, :presence => true
  validate :check_number_of_attempts_by_survey

  #scopes
  scope :wins,   -> { where(:winner => true) }
  scope :looses, -> { where(:winner => false) }
  scope :scores, -> { order("score DESC") }
  scope :for_survey, ->(survey) { where(:survey_id => survey.id) }
  scope :exclude_survey,  ->(survey) { where("NOT survey_id = #{survey.id}") }
  scope :for_participant, ->(participant) {
    where(:participant_id => participant.try(:id), :participant_type => participant.class.base_class)
  }

  # callbacks
  before_create :collect_scores

  def case
    participant
  end

  def correct_answers
    return self.answers.where(:correct => true)
  end

  def incorrect_answers
    return self.answers.where(:correct => false)
  end

  def self.high_score
    return scores.first.score
  end

  def can_do_one_more_attempt?(participant)
    attempts = self.class.for_survey(survey).for_participant(participant)
    upper_bound = self.survey.attempts_number

    if attempts.size >= upper_bound && upper_bound != 0
      return false
    end
    true
  end

  def to_s
    "ATTEMPT FOR #{survey}"
  end

  def to_pdf(pdf)
     pdf.text "ATTEMPT #{defined?(index) ? "##{index + 1}" : nil}"
     pdf.text answers.first.created_at.strftime(Setting['format_date']) if answers.first
     pdf.table( [["Survey", survey.to_s ]], :column_widths => [ 150, 373])
     pdf.table( [["Survey Status", survey.active? ? 'Active' : (survey.finished? ? 'Finished' : 'Not active') ]], :column_widths => [ 150, 373])
     pdf.move_down(10)

     answers.each do |answer|
       pdf.text answer.question.text

       answer.question.options.each do |option|
         pdf.text "(#{answer.option_id == option.id ? 'X' : ' '}) #{option.text}"
       end
       pdf.move_down(7)
     end
  end

  private

  def check_number_of_attempts_by_survey
    attempts = self.class.for_survey(survey).for_participant(participant)
    upper_bound = self.survey.attempts_number

    if attempts.size >= upper_bound && upper_bound != 0
      errors.add(:survey_id, "Number of attempts exceeded")
    end
  end

  def collect_scores
    self.score = self.answers.map(&:value).reduce(:+) || 0
  end


end
