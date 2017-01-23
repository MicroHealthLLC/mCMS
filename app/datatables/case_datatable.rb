class CaseDatatable < AjaxDatatablesRails::Base

  def_delegators :@view,
                 :link_to

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
    Case.title
    Enumeration.name
    Enumeration.name
    Enumeration.name
    Enumeration.name
    Case.date_start
    Case.date_due
    Case.date_completed
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
    Case.title
    Enumeration.name

    }
  end

  private

  def data
    records.map do |c|
      [
          @view.link_to(c.title, @view.case_path(c) ),
          c.priority_type.to_s,
          c.case_type.to_s,
          c.case_status_type.to_s,
          c.case_category_type.to_s,
          c.date_start,
          c.date_due,
          c.date_completed
      ]
    end
  end

  def get_raw_records
    scope = if @options[:subcases]
              Case.subcases
            else
              Case.root
            end
    scope = scope.include_enumerations
    scope = if User.current.can?(:manage_roles)
              scope.where(assigned_to_id: User.current)
            else
              scope.visible
            end
    scope
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
