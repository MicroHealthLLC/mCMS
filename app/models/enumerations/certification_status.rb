class CertificationStatus < Enumeration
  has_many :certifications

  OptionName = :enumeration_certification_status

  def option_name
    OptionName
  end

  def objects
    Certification.where(:status_id => self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:status_id => to.id)
  end
end