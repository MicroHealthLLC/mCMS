class RelatedClient < ApplicationRecord
  belongs_to :user
  belongs_to :relationship, optional: true
  belongs_to :related_client, class_name: 'User'

  validates_presence_of :user_id, :related_client_id

  def to_s
    related_client
  end

  def relationship
    if relationship_id
      super
    else
      Relationship.default
    end
  end

  def self.safe_attributes
    [
        :user_id, :related_client_id, :relationship_id,
        :date_start, :date_end, :description
    ]
  end
end
