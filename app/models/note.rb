class Note < ApplicationRecord
  belongs_to :user
  scope :not_private, -> {where(is_private: false)}
  default_scope -> {where(is_private: false).or(where(private_author_id: User.current.id)) }


  def self.safe_attributes
    [:user_id, :owner_id, :type, :note, :is_private, :private_author_id]
  end

  before_create :check_private_author

  def check_private_author
    if self.is_private
      self.private_author_id = User.current.id
    end
  end

  def object

  end

end
