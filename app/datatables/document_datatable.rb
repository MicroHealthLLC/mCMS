class DocumentDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
        'Document.title',
        @options[:show_case] ? 'Case.title' : nil ,
        'Enumeration.name',
        'Document.date',
        'Document.expiration_date'
    ].compact
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
        'Document.title',
        @options[:show_case] ? 'Case.title' : nil ,
        'Enumeration.name', 'Document.date',
        'Document.expiration_date'

    ].compact
  end

  private

  def data
    records.map do |document|
      tab = []
      tab << @view.link_to_edit_if_can(document.title, {ctrl: (document.related_to_id ? :documents : :client_documents), object: document })
      tab << @view.link_to_case(document.case) if @options[:show_case]
      tab << document.document_type.to_s
      tab << @view.format_date(document.date).to_s
      tab << @view.format_date(document.expiration_date).to_s
      if  @options[:appointment_id] and User.current_user.can?(:manage_roles)
        tab << @view.link_to("<i class='fa fa-unlink fa-lg'></i>".html_safe, @view.unlink_appointment_path(appointment_id: @appointment.id, type: 'Document', id: document.id ))
      end

      tab
    end
  end

  def get_raw_records
    @appointment = Appointment.find @options[:appointment_id] if @options[:appointment_id]
    scope = if @options[:for] == 'profile'
              Document.for_profile
            else
              if @options[:case_id]
                Case.find(@options[:case_id]).documents
              else
                Document.for_cases
              end
            end

    scope = scope.include_enumerations
    scope.for_status @options[:status_type]
  end
end
