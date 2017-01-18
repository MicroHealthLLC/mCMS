class CaseSupportAttachment < Attachment
  belongs_to :case_support, foreign_key: :owner_id

  def owner
    self.case_support
  end

end