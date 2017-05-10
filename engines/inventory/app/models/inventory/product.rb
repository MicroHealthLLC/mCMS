module Inventory
  class Product < ApplicationRecord
    belongs_to :product_category, optional: true
    belongs_to :product_type, optional: true
    belongs_to :product_status, optional: true

    has_many :product_assigns

    def product_category
      super || ProductCategory.default
    end

    def product_type
      super || ProductType.default
    end

    def product_status
      super || ProductStatus.default
    end

    def to_s
      name
    end

    def self.safe_attributes
      [:name, :description, :product_category_id, :product_type_id, :manufacturer, :model, :serial, :uni_cost, :product_status, :product_status_id]
    end

    def to_pdf

    end
  end
end
