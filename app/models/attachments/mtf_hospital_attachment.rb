class MtfHospitalAttachment < Attachment
  belongs_to :owner, class_name: 'MtfHospital'
end