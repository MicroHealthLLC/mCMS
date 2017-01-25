class EmployeeDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      Enumeration.name
      CoreDemographic.birth_date
      User.state
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      Enumeration.name
      CoreDemographic.birth_date
      User.state
    }
  end

  private

  def data
    records.map do |user|
      [
          @view.link_to( user.id,  @view.log_in_employee_path(user)) ,
          @view.link_to( user.first_name.to_s,  @view.log_in_employee_path(user)) ,
          user.middle_name ,
          user.last_name,
          user.gender.to_s,
          user.email ,
          user.birthday ,
          user.state,
          @view.link_to('<i class="fa fa-download"></i>'.html_safe,  @view.all_informations_path(format: 'pdf'))

      ]
    end
  end

  def get_raw_records
    if User.current_user.allowed_to?(:manage_roles)
      User.employees.
          includes(:core_demographic=> :gender_type).
          references(:core_demographic=> :gender_type)
    else
      User.where(id: User.current.id).
          includes(:core_demographic=> :gender_type).
          references(:core_demographic=> :gender_type)
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
