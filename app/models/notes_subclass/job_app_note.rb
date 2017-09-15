class JobAppNote < Note
  belongs_to :job_app, foreign_key: :owner_id, class_name: 'JobApp'

  def object
    job_app
  end
end