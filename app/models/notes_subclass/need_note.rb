class NeedNote < Note
  belongs_to :need, foreign_key: :owner_id, class_name: 'Need'

  def object
    need
  end

end
