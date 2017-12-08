class ProblemListDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      ProblemList.name
      ProblemList.snomed
      ProblemList.date_onset
      ProblemList.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
       ProblemList.name
      ProblemList.snomed
      ProblemList.date_onset
      ProblemList.date_resolved
      Enumeration.name
      Enumeration.name
    }
  end

  private

  def data
    records.map do |problem_list|
      [
          @view.link_to_edit_if_can(problem_list.name, {ctrl: :problem_lists, object: problem_list }) ,
          @view.link_to_edit_if_can(problem_list.snomed, {ctrl: :problem_lists, object: problem_list } ),
          @view.format_date( problem_list.date_onset) ,
          @view.format_date( problem_list.date_resolved) ,
          problem_list.problem_status.to_s ,
          problem_list.problem_type.to_s
      ]

    end
  end

  def get_raw_records
    scope = ProblemList.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
