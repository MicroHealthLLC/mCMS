class EmployeeDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
        User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.gender
      CoreDemographic.birth_date
      User.state
      Organization.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.id
      CoreDemographic.first_name
      CoreDemographic.middle_name
      CoreDemographic.last_name
      CoreDemographic.gender
      CoreDemographic.birth_date
      User.state
      Organization.name
    }
  end

  private

  def data
    records.map do |user|
      [
          @view.link_to( user.id,  @view.employee_path(user), 'data-turbolinks'=> false) ,
          @view.link_to( user.first_name.to_s,  @view.log_in_employee_path(user), 'data-turbolinks'=> false) ,
          user.middle_name ,

          user.last_name,
          user.gender.to_s,
          user.email ,

          user.birthday ,
          user.organization.to_s,
          user.state,
          @view.link_to('<i class="fa fa-download" ></i>'.html_safe,  @view.all_informations_path(format: 'pdf'))

      ]
    end
  end

  def get_raw_records
    scope = User.employees.include_enumerations.
        includes(:job_detail=> [:organization]).
        references(:job_detail=> [:organization])

    case @options[:status_type]
      when 'active' then scope.where(state: true)
      when 'inactive' then scope.where(state: false)
      when 'all' then scope
      else
        scope.where(state: true)
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
