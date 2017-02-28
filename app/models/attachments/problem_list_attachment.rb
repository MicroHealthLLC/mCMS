class ProblemListAttachment < Attachment
  belongs_to :owner, class_name: 'ProblemList'
end