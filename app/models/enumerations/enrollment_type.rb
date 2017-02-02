class EnrollmentType < Enumeration
  has_many :enrollments

  OptionName = :enumerations_enrollment_types

  def option_name
    OptionName
  end

  def objects
    Enrollment.where(:enrollment_type_id=> self.id)
  end

  def objects_count
    objects.count
  end

  def transfer_relations(to)
    objects.update_all(:enrollment_type_id => to.id)
  end
end