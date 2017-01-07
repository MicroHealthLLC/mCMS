module GoalsHelper
  def goal_back_url(goal)
    if goal.case
      case_path(goal.case)
    else
      goals_path
    end
  end
end
