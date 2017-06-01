module Lms
  class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :lesson

    validates_presence_of :content, :user_id, :lesson_id

    def self.safe_attributes
      [:lesson_id, :user_id, :content]
    end
  end
end
