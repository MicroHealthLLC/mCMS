module Inventory
  class ProductLocation < Enumeration
    has_many :products, class_name: 'Inventory::Product'

    OptionName = :enumeration_product_location

    def option_name
      OptionName
    end

    def objects
      Inventory::Product.where(:product_location_id => self.id)
    end

    def objects_count
      objects.count
    end

    def transfer_relations(to)
      objects.update_all(:product_location_id => to.id)
    end
  end
end