class ReferralRelation < ApplicationRecord
  belongs_to :referral_parent, class_name: 'Referral'
  belongs_to :referral_child, class_name: 'Referral'
end
