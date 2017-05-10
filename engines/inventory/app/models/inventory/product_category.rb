module Inventory
  class ProductCategory < Enumeration
    has_many :products

    OptionName = :enumeration_product_category

    def option_name
      OptionName
    end

    def objects
      Inventory::Product.where(:product_category_id => self.id)
    end

    def objects_count
      objects.count
    end

    def transfer_relations(to)
      objects.update_all(:product_category_id => to.id)
    end
  end
end