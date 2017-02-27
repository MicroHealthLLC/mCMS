class ReferralNote < Note
  belongs_to :referral, foreign_key: :owner_id, class_name: 'Referral'

  def object
    referral
  end

end
