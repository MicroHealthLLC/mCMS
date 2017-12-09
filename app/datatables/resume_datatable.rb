class ResumeDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Resume.title
      Resume.date
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Resume.title
      Resume.date
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |resume|
      [
          @view.link_to_edit_if_can( resume.title, {ctrl: :resumes, object: resume }) ,

          @view.format_date( resume.date ),
          resume.resume_type.to_s ,
          resume.resume_status.to_s ,
      ]

    end
  end

  def get_raw_records
    scope = Resume.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
