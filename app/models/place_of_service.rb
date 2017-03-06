class PlaceOfService < ApplicationRecord
  has_many :appointments

  def to_s
    "(#{code}) #{name}"
  end
end
