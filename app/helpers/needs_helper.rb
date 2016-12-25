module NeedsHelper
  def need_back_url(need)
    if need.case
      case_path(need.case)
    else
      needs_path
    end
  end
end
