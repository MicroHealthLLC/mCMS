class CaseSupportDatatable < AjaxDatatablesRails::Base

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name
    arr = []
    arr << ['CaseSupport.first_name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'CaseSupport.date_start',
          'CaseSupport.date_ended'
        ]

    @sortable_columns = arr.flatten
  end

  def searchable_columns

    return @searchable_columns if @searchable_columns
    # Declare strings in this format: ModelName.column_name
    arr = []
    arr << ['CaseSupport.first_name']
    if @options[:show_case] == 'true'
      arr << 'Case.title'
    end

    arr <<
        [ 'Enumeration.name',
          'Enumeration.name',
          'CaseSupport.date_start',
          'CaseSupport.date_ended'
        ]

    @searchable_columns = arr.flatten
  end

  private

  def data

    records.map do |case_support|
      arr = Array.new
      arr << @view.link_to_edit_if_can(case_support.name, {ctrl: :case_supports, object: case_support })
      if @options[:show_case] == 'true'
        arr << @view.link_to_case( case_support.case)
      end
      arr<< [
          case_support.case_support_type.to_s ,
          case_support.support_status.to_s ,

          @view.format_date( case_support.date_started ),
          @view.format_date( case_support.date_ended)
      ]
      if @options[:appointment_id] and User.current_user.can?(:manage_roles)
        arr<<  @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'CaseSupport', id: case_support.id ))
      end
      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      CaseSupport.include_enumerations.where(id: @appointment_links.where(linkable_type: 'CaseSupport').map(&:linkable).map(&:id))
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).case_supports.include_enumerations
              else
                CaseSupport.include_enumerations
              end
      scope.for_status @options[:status_type]
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
