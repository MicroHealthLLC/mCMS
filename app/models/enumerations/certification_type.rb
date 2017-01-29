class CertificationType < Enumeration
  has_many :certifications

  OptionName = :enumeration_certification_type

  def option_name
    OptionName
  end

  def objects
    Certification.where(:certification_type_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:certification_type_id => to.id)
  end
end