class RelatedClientDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
            User.login
      RelatedClient.snomed
      RelatedClient.date_start
      RelatedClient.date_end
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      User.login
      RelatedClient.snomed
      RelatedClient.date_start
      RelatedClient.date_end
    }
  end

  private

  def data
    records.map do |related_client|
      [
          @view.link_to_edit_if_can( related_client.related_client, {ctrl: :related_clients, object: related_client }) ,
          related_client.snomed ,
          @view.format_date( related_client.date_start) ,
          @view.format_date( related_client.date_end) ,
      ]

    end
  end

  def get_raw_records
    scope = RelatedClient.include_enumerations
    scope.visible
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
