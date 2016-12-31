class CaseSupportExtendDemography < ExtendDemography
  belongs_to :case_support

  def object
    case_support
  end
end
