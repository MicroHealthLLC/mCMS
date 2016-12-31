class NoteTemplate < ApplicationRecord

  def self.safe_attributes
    [:title, :note]
  end
end
