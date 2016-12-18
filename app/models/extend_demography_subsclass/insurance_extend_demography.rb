class InsuranceExtendDemography < ExtendDemography
  belongs_to :insurance

  def object
    insurance
  end
end
