class ReferralStatus < Enumeration
  has_many :referrals

  OptionName = :enumeration_referral_status

  def option_name
    OptionName
  end

  def objects
    Referral.where(:referral_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:referral_status_id => to.id)
  end
end