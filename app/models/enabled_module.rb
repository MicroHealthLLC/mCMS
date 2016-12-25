class EnabledModule < ApplicationRecord
  scope :active, -> { where(status: true)}
end
