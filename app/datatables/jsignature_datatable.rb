class JsignatureDatatable < AjaxDatatablesRails::Base

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
          @view.link_to(jsignature.person_name, jsignature ),
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
      @appointment_links = @appointment.appointment_links.includes(:linkable)
      Jsignature.include_enumerations.where(id: @appointment_links.where(linkable_type: 'Jsignature').map(&:linkable).map(&:id))
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
