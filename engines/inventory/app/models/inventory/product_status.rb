module Inventory
  class ProductStatus < Enumeration
    has_many :products

    OptionName = :enumeration_product_status

    def option_name
      OptionName
    end

    def objects
      Inventory::Product.where(:product_status_id => self.id)
    end

    def objects_count
      objects.count
    end

    def transfer_relations(to)
      objects.update_all(:product_status_id => to.id)
    end
  end
end