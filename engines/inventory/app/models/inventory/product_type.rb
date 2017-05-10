module Inventory
  class ProductType < Enumeration
    has_many :products

    OptionName = :enumeration_product_type

    def option_name
      OptionName
    end

    def objects
      Inventory::Product.where(:product_type_id => self.id)
    end

    def objects_count
      objects.count
    end

    def transfer_relations(to)
      objects.update_all(:product_type_id => to.id)
    end
  end
end