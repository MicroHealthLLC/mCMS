class BehavioralRiskAttachment < Attachment
  belongs_to :owner, class_name: 'BehavioralRisk'
end