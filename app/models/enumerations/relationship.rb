class Relationship < Enumeration
  has_many :related_clients

  OptionName = :enumeration_relationship

  def option_name
    OptionName
  end

  def objects
    RelatedClient.where(:relationship_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:relationship_id => to.id)
  end
end