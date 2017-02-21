class ImmunizationCvx < ApplicationRecord
  def to_s
    "#{cvx_code} - #{cvx_short_description} - #{vaccinestatus}"
  end
end
