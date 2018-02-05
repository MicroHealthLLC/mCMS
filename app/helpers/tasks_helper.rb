module TasksHelper
  def get_back_url task
    if task.related_to_id
      if task.related_to_type == 'case'
        return case_path(task.related_to_id)
      else
        return task_path(task.related_to_id)
      end
    end
    tasks_path
  end
end
