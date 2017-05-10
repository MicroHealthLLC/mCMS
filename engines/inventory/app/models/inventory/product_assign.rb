module Inventory
  class ProductAssign < ApplicationRecord
    belongs_to :user
    belongs_to :product
    belongs_to :assignment_status, optional: true

    def assignment_status
      super || AssignmentStatus.default
    end

    def self.safe_attributes
      [:product_id, :user_id, :date, :assignment_status_id]
    end

    def to_s
      product.name
    end
  end
end
