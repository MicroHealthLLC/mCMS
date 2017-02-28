class DepartmentAttachment < Attachment
  belongs_to :owner, class_name: 'Department'
end