class CertificationDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Certification.name
      Enumeration.name
      Enumeration.name
      Certification.date_received
      Certification.date_expired
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Certification.name
      Enumeration.name
      Enumeration.name
      Certification.date_received
      Certification.date_expired
    }
  end

  private

  def data
    records.map do |certification|
      [
          @view.link_to_edit_if_can( certification.name, {ctrl: :certifications, object: certification }) ,
          certification.certification_type.to_s ,
          certification.certification_status.to_s ,
          @view.format_date( certification.date_received) ,
          @view.format_date( certification.date_expired) ,
      ]

    end
  end

  def get_raw_records
    scope = Certification.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
