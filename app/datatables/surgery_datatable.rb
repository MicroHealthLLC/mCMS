class SurgeryDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Surgical.name
      Surgical.hcpc
      Surgical.medical_facility
      Enumeration.name
      Enumeration.name
      Surgical.surgery_date
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Surgical.name
      Surgical.hcpc
      Surgical.medical_facility
      Enumeration.name
      Enumeration.name
      Surgical.surgery_date
    }
  end

  private

  def data
    records.map do |surgical|
      [
          @view.link_to_edit_if_can(surgical.name, {ctrl: :surgicals, object: surgical } ),
          surgical.hcpc.present? ? @view.link_to_edit_if_can( surgical.hcpc, {ctrl: :surgicals, object: surgical }) : '' ,
          surgical.medical_facility ,
          surgical.surgery_status.to_s ,
          surgical.surgery_type.to_s ,
          @view.format_date(surgical.surgery_date) ,
      ]

    end
  end

  def get_raw_records
    scope = Surgical.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
