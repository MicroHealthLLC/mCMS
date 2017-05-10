module Inventory
  class Product < ApplicationRecord
    belongs_to :product_category, optional: true
    belongs_to :product_type, optional: true
    belongs_to :product_status, optional: true
    belongs_to :product_location, optional: true

    has_many :product_assigns

    validates_presence_of :name

    def product_category
      super || ProductCategory.default
    end

    def product_type
      super || ProductType.default
    end

     def product_location
      super || ProductLocation.default
    end

    def product_status
      super || ProductStatus.default
    end

    def to_s
      name
    end

    def self.safe_attributes
      [:name, :description, :product_category_id, :product_type_id,
       :manufacturer, :model, :serial, :unit_cost, :product_location_id, :product_status_id]
    end

    def to_pdf(pdf, show_user = true)
      pdf.font_size(25){  pdf.table([[ "Product ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}

      pdf.table([[ "Name: ", " #{name}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Description: ", " #{ActionView::Base.full_sanitizer.sanitize(description)}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Product type: ", " #{product_type}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Product status: ", " #{product_status}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Product category: ", " #{product_category}"]], :column_widths => [ 150, 373])
      pdf.table([[ "manufacturer: ", " #{manufacturer}"]], :column_widths => [ 150, 373])
      pdf.table([[ "model: ", " #{model}"]], :column_widths => [ 150, 373])
      pdf.table([[ "unit cost: ", " #{unit_cost}"]], :column_widths => [ 150, 373])
      pdf.table([[ "product location: ", " #{product_location}"]], :column_widths => [ 150, 373])

    end

  end
end
