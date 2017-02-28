class EnvironmentRiskAttachment < Attachment
  belongs_to :owner, class_name: 'EnvironmentRisk'
end