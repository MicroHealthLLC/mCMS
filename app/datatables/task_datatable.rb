class TaskDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      Task.title
      Case.title
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Task.date_start
      Task.date_completed
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      Task.title
      Case.title
      Enumeration.name
      Enumeration.name
      Enumeration.name
      Task.date_start
      Task.date_completed
    }
  end

  private

  def data
    records.map do |task|
      [
          @view.link_to( task.title, task) ,
          @view.link_to_case( task.case),
          task.task_type.to_s,
          task.task_status_type.to_s ,
          task.priority_type.to_s ,
          task.date_start ,
          task.date_completed
      ]
    end
  end

  def get_raw_records
    @tasks = Task.root.include_enumerations.
        where('tasks.assigned_to_id = :user OR tasks.for_individual_id = :user', user:  User.current.id)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
