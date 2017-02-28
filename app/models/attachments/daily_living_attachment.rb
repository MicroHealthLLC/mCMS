class DailyLivingAttachment < Attachment
  belongs_to :owner, class_name: 'DailyLiving'
end