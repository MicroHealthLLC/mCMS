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
    tabs =  [
        {:name => 'subcases', :partial => 'cases/show_case/subcases', :label => :subcases},
        {:name => 'case_support', :partial => 'cases/show_case/case_support', :label => :case_support},
        {:name => 'notes', :partial => 'cases/show_case/notes', :label => :notes},
        {:name => 'needs', :partial => 'cases/show_case/needs', :label => :needs},
        {:name => 'goals', :partial => 'cases/show_case/goals', :label => :goals},
        {:name => 'plans', :partial => 'cases/show_case/plans', :label => :plans},
        {:name => 'tasks', :partial => 'cases/show_case/tasks', :label => :tasks},
        {:name => 'signatures', :partial => 'cases/show_case/jsignatures', :label => :signatures},
        {:name => 'documents', :partial => 'cases/show_case/documents', :label => :documents},
        {:name => 'enrollments', :partial => 'cases/show_case/enrollments', :label => :enrollments},
        {:name => 'teleconsults', :partial => 'cases/show_case/teleconsults', :label => :teleconsults},
        {:name => 'checklists', :partial => 'cases/show_case/checklists', :label => :checklists},
        {:name => 'transports', :partial => 'cases/show_case/transports', :label => :transports},
        {:name => 'measurement_records', :partial => 'cases/show_case/measurement_records', :label => :measurement_records},
        {:name => 'appointments', :partial => 'cases/show_case/appointments', :label => :appointments},
        {:name => 'referrals', :partial => 'cases/show_case/referrals', :label => :referrals},
        {:name => 'surveys', :partial => 'cases/show_case/surveys', :label => :surveys},
        {:name => 'case_organizations', :partial => 'cases/show_case/case_organizations', :label => :case_organizations},
        {:name => 'watcher', :partial => 'cases/show_case/watcher', :label => :watcher},
    ]
    tabs
  end

end
