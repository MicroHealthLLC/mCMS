class ContactDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Contact.first_name
      Contact.emergency_contact
      Enumeration.name
      Enumeration.name
      Contact.language
      Contact.date_started
      Contact.date_ended
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Contact.first_name
      Contact.emergency_contact
      Enumeration.name
      Enumeration.name
      Contact.language
      Contact.date_started
      Contact.date_ended
    }
  end

  private

  def data
    records.map do |contact|
      [
          @view.link_to_edit_if_can(contact.name, {ctrl: :contacts, object: contact }),
          contact.emergency_contact,
          contact.contact_type.to_s,
          contact.contact_status.to_s,
          contact.language.to_s,
          @view.format_date( contact.date_started),
          @view.format_date( contact.date_ended),
      ]



    end
  end

  def get_raw_records
    scope = Contact.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
