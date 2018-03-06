class JsignatureDatatable < Abstract

  def sortable_columns

    return @sortable_columns if @sortable_columns
    # Declare strings in this format: ModelName.column_name

    arr = [
        'Jsignature.person_name',
        'User.login',
        'User.login',
        'Jsignature.created_at'
    ]

    @sortable_columns = arr.flatten
  end

  def searchable_columns

    return @searchable_columns if @searchable_columns
    # Declare strings in this format: ModelName.column_name

    arr  =  [
        'Jsignature.person_name',
        'User.login',
        'User.login',
        'Jsignature.created_at'
    ]

    @searchable_columns = arr.flatten
  end

  private

  def data
    records.map do |jsignature|
      arr = Array.new

      arr<< [
          @view.link_to_edit_if_can( jsignature.person_name, {ctrl: :jsignatures, object: jsignature } ) ,
          jsignature.user.to_s ,
          jsignature.user.user_title ,
          @view.format_date_time( jsignature.created_at ),
          @view.image_tag(jsignature.signature.html_safe, size: '200x100')
      ]

      arr.flatten
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    if @options[:appointment_id]
      @appointment.jsignatures.include_enumerations
    else
      scope = if @options[:case_id]
                Case.find(@options[:case_id]).jsignatures.include_enumerations
              else
                @jsignatures = User.current.jsignatures.include_enumerations

              end
      scope.filter_status 'all'
    end
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
