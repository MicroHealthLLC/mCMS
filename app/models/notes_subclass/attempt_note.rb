class AttemptNote < Note
  belongs_to :attempt, foreign_key: :owner_id, class_name: 'Survey::Attempt'

  def object
    attempt
  end
end