module Inventory
class AssignmentStatus < Enumeration
has_many :product_assigns

  OptionName = :enumeration_assignment_status

  def option_name
    OptionName
  end

  def objects
    Inventory::ProductAssign.where(:assignment_status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:assignment_status_id => to.id)
  end
end
end