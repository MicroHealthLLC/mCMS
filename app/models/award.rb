class Award < ApplicationRecord
  belongs_to :user
  belongs_to :award_enum, optional: true
  belongs_to :award_type, optional: true
end
