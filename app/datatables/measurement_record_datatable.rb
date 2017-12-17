class MeasurementRecordDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    return @sortable_columns if @sortable_columns
    arr = ['MeasurementRecord.measurement',
           'Measurement.component',
           'MeasurementRecord.measure',
           'MeasurementRecord.measured_by',
           'MeasurementRecord.date_time',
           'User.login',
           'MeasurementRecord.flag',
           'Enumeration.name'
    ]
    @sortable_columns = arr.flatten
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    return @searchable_columns if @searchable_columns
    arr = ['MeasurementRecord.measurement',
           'Measurement.component',
           'MeasurementRecord.measure',
           'MeasurementRecord.measured_by',
           'MeasurementRecord.date_time',
           'User.login',
           'MeasurementRecord.flag',
           'Enumeration.name'
    ]
    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |measurement_record|
      [
          @view.link_to_edit_if_can( measurement_record.measurement, {ctrl: :measurement_records, object: measurement_record }),
          measurement_record.component.component,
          measurement_record.measure,
          measurement_record.measured_by.to_s,
          @view.format_date_time(  measurement_record.date_time),
          measurement_record.recorded_by.to_s,
          measurement_record.flag.to_s,
          measurement_record.measurement_status.to_s
      ]
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      MeasurementRecord.include_enumerations.
          where(id: @appointment_links.where(linkable_type: 'MeasurementRecord').map(&:linkable).map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).measurement_records.include_enumerations
              else
                MeasurementRecord.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
