module PlansHelper
  def plan_back_url(plan)
    if plan.case
      case_path(plan.case)
    else
      plans_path
    end
  end
end
