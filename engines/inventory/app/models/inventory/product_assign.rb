module Inventory
  class ProductAssign < ApplicationRecord
    belongs_to :user
    belongs_to :product
    belongs_to :assignment_status, optional: true

    validates_presence_of :user_id , :product_id
    def assignment_status
      super || AssignmentStatus.default
    end

    def self.safe_attributes
      [:product_id, :user_id, :date, :assignment_status_id]
    end

    def to_s
      product.try(:name)
    end

    def to_pdf(pdf, show_user = true)
      pdf.font_size(25){  pdf.table([[ "Product Assign ##{id}"]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})}
      user.to_pdf_brief_info(pdf) if show_user
      pdf.table([[" Product Assign "]], :row_colors => ['eeeeee'], :column_widths => [ 523], :cell_style=> {align: :center})

      pdf.table([[ "Product: ", " #{product.name}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Date: ", " #{date}"]], :column_widths => [ 150, 373])
      pdf.table([[ "Assignment status: ", " #{assignment_status}"]], :column_widths => [ 150, 373])
      end


  end
end
