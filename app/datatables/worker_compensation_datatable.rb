class WorkerCompensationDatatable < Abstract

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Injury.injury_name
      Enumeration.name
      Enumeration.name
      WorkerCompensation.date_of_compensation_start
      WorkerCompensation.date_of_compensation_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Injury.injury_name
      Enumeration.name
      Enumeration.name
      WorkerCompensation.date_of_compensation_start
      WorkerCompensation.date_of_compensation_end
    }
  end

  private

  def data
    records.map do |worker_compensation|
      [
          @view.link_to_edit_if_can(worker_compensation.injury.to_s, {ctrl: :worker_compensations, object:  worker_compensation }) ,
          worker_compensation.compensation_type.to_s ,
          worker_compensation.compensation_status.to_s ,
          @view.format_date( worker_compensation.date_of_compensation_start) ,
          @view.format_date( worker_compensation.date_of_compensation_end)
      ]

    end
  end

  def get_raw_records
    # scope = WorkerCompensation.include_enumerations
    # scope.for_status @options[:status_type]

    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      WorkerCompensation.include_enumerations.where(id: @appointment_links.where(linkable_type: 'WorkerCompensation').map(&:linkable).compact.map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).worker_compensations.include_enumerations
              else
                WorkerCompensation.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
