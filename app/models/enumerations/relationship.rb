class Relationship < Enumeration
  has_many :enrollments

  OptionName = :enumeration_relationship

  def option_name
    OptionName
  end

  def objects
    Enrollment.where(:relationship_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:relationship_id => to.id)
  end
end