class PlanNote < Note
  belongs_to :plan, foreign_key: :owner_id, class_name: 'Plan'

  def object
    plan
  end

end
