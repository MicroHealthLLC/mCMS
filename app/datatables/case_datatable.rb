class CaseDatatable < Abstract

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
    Enumeration.name
    Enumeration.name
    Enumeration.name
    Enumeration.name
    Case.date_start
    Case.date_due
    Case.date_completed
    }
  end

  private

  def data
    if User.current.can?(:manage_roles)
      records.map do |c|
        [
            "<b>#{c.user.to_s}<b/>".html_safe,
            @view.link_to_edit_if_can( c.title, {ctrl: :cases, object: c } ),
            c.priority_type.to_s,
            c.case_type.to_s,
            c.case_status_type.to_s,
            c.case_category_type.to_s,
            c.case_source.to_s,
            c.date_start,
            c.date_due,
            c.date_completed
        ]
      end
    else
      records.map do |c|
        [
            @view.link_to_edit_if_can( c.title, {ctrl: :cases, object: c } ),
            c.priority_type.to_s,
            c.case_type.to_s,
            c.case_status_type.to_s,
            c.case_category_type.to_s,
            c.case_source.to_s,
            c.date_start,
            c.date_due,
            c.date_completed
        ]
      end

    end
  end

  def get_raw_records
    scope = Case
    scope = case @options[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.opened
            end
    scope = scope.include_enumerations
    scope = if User.current.can?(:manage_roles)
              scope.where(assigned_to_id: User.current)
            else
              scope.visible
            end
    if  User.current_user.admin? or User.current.organization == User.current_user.organization
      scope
    else
      org = User.current_user.organization
      co = CaseOrganization.where(organization_id: org.try(:id)).where(case_id: User.current.cases.pluck(:id)).pluck(:case_id)
      scope.where(id: co)
    end

  end

  # ==== Insert 'presenter'-like methods below if necessary
end
