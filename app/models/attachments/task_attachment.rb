class TaskAttachment < Attachment
  belongs_to :task, foreign_key: :owner_id

  def owner
    self.task
  end

end