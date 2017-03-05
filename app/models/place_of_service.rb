class PlaceOfService < ApplicationRecord
  has_many :appointments

  def to_s
    "#{name} -- #{description}"
  end
end
