class ImmunizationCvx < ApplicationRecord
  def to_s
    "#{cvx_code} - #{short_description} - #{vaccinestatus}"
  end
end
