class JobAppDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
       JobApp.title
      Occupation.code
      JobApp.employer
      JobApp.date_applied
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      JobApp.title
      Occupation.code
      JobApp.employer
      JobApp.date_applied
      Enumeration.name
    }
  end

  private

  def data
    records.map do |job_app|
      [
          @view.link_to_edit_if_can( job_app.title, {ctrl: :job_apps, object: job_app }) ,
          job_app.occupation.to_s ,
          job_app.employer.to_s ,
          @view.format_date(job_app.date_applied) ,
          job_app.app_state.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = JobApp.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
