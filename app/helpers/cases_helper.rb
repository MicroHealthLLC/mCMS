module CasesHelper
  def show_relation_path(relation)
    if relation.relation.is_a?(Survey::Survey)
      link_to(relation.relation, surveys_path(relation.relation) )
    else
      link_to(relation.relation, relation.relation )
    end
  end

  def case_back_url obj
    obj.subcase_id ? obj.case : cases_path
  end

  def case_tabs
    tabs =  [ ]

    if @needs or @plans or @goals or @tasks or @jsignatures
      tabs<< {:name => 'care_plan', :partial => 'cases/show_case/care_plan', :label => :care_plan}
    end
    if @cases
      tabs<<  {:name => 'subcases', :partial => 'cases/show_case/subcases', :label => :subcases}
    end

    if @case_supports
      tabs<< {:name => 'case_supports', :partial => 'cases/show_case/case_support', :label => :case_supports}
    end

    if @notes
      tabs<<  {:name => 'notes', :partial => 'cases/show_case/notes', :label => :notes}
    end

    if @documents
      tabs<< {:name => 'documents', :partial => 'cases/show_case/documents', :label => :documents}
    end

    if @enrollments
      tabs<< {:name => 'enrollments', :partial => 'cases/show_case/enrollments', :label => :enrollments}
    end

    if @teleconsults
      tabs<< {:name => 'teleconsults', :partial => 'cases/show_case/teleconsults', :label => :teleconsults}
    end

    if @checklists
      tabs<< {:name => 'checklists', :partial => 'cases/show_case/checklists', :label => :checklists}
    end

    if @transports
      tabs<< {:name => 'transports', :partial => 'cases/show_case/transports', :label => :transports}
    end

    if @measurement_records
      tabs<< {:name => 'measurement_records', :partial => 'cases/show_case/measurement_records', :label => 'Measurements'}
    end

    if @appointments
      tabs<< {:name => 'appointments', :partial => 'cases/show_case/appointments', :label => :appointments}
    end

    if @referrals
      tabs<<    {:name => 'referrals', :partial => 'cases/show_case/referrals', :label => :referrals}
    end

    if @surveys
      tabs<< {:name => 'surveys', :partial => 'cases/show_case/surveys', :label => :surveys}
    end

    if @case_organizations
      tabs<<  {:name => 'case_organizations', :partial => 'cases/show_case/case_organizations', :label => 'Share Organization'}
    end

    if @watchers
      tabs<< {:name => 'watcher', :partial => 'cases/show_case/watcher', :label => 'Share Individual'}
    end

    tabs
  end

  def care_plan_tab
    tabs = [ ]
    if @needs
      tabs<<  {:name => 'needs', :partial => 'cases/show_case/needs', :label => :needs}
    end

    if @goals
      tabs<<  {:name => 'goals', :partial => 'cases/show_case/goals', :label => :goals}
    end

    if @plans
      tabs<< {:name => 'plans', :partial => 'cases/show_case/plans', :label => :plans}
    end

    if @tasks
      tabs<< {:name => 'tasks', :partial => 'cases/show_case/tasks', :label => :tasks}
    end

    if @jsignatures
      tabs<<  {:name => 'signatures', :partial => 'cases/show_case/jsignatures', :label => :signatures}
    end
    tabs
  end

end
