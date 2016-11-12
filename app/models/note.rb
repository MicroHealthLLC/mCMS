class Note < ApplicationRecord
  belongs_to :user
  scope :not_private, -> {where(is_private: false)}

  def self.safe_attributes
    [:user_id, :owner_id, :type, :note, :is_private]
  end

  def object

  end

end
