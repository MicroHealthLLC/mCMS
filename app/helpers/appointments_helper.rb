module AppointmentsHelper
  def appointment_back_url appointment
    appointment.related_to_id ? appointment.case : appointments_path
  end

  def date_time_form(datetime)
    datetime.strftime("%Y-%m-%d %I:%M %p") if datetime
  end

  def appointment_tabs
    tabs =  [ ]
    tabs<< {:name => 'capture', :partial => 'appointments/partials/captures', :label => 'Assessments'}
    tabs<< {:name => 'disposition', :partial => 'appointments/partials/disposition', :label => 'Dispositions'}
    tabs<< {:name => 'procedure', :partial => 'appointments/partials/procedure', :label => 'Procedures'}
    if module_enabled? 'billings'
      tabs<< {:name => 'billing', :partial => 'appointments/partials/billing', :label => 'Billings'}
    end
    tabs<< {:name => 'note', :partial => 'appointments/partials/notes', :label => 'Notes'}
    tabs<< {:name => 'signature', :partial => 'appointments/partials/signature', :label => 'Signatures'}
    tabs
  end

  def appointment_case_tabs
    tabs =  [ ]
    tabs<< {:name => 'needs', partial: 'cases/show_case/needs' , :label => 'Needs'} if module_enabled?('needs')
    tabs<< {:name => 'goals', partial: 'cases/show_case/goals' , :label => 'Goals'} if module_enabled?('goals')
    tabs<< {:name => 'plans', partial: 'cases/show_case/plans' , :label => 'Plans'} if module_enabled?('plans')
    tabs<< {:name => 'tasks', partial: 'cases/show_case/tasks' , :label => 'Actions'} if module_enabled?('tasks')
    tabs<< {:name => 'signatures', partial: 'cases/show_case/jsignatures', :label => 'Signatures'} if module_enabled?('jsignatures')
 #   if module_enabled?('needs') or module_enabled?('goals') or module_enabled?('plans') or module_enabled?('tasks') or module_enabled?('jsignatures')
 #     tabs<< {:name => 'appt_care_plan', partial: 'appointments/appt_care_plan', :label => 'Care Plan'}
 #   end    
    tabs<< {:name => 'subcases', partial: 'cases/show_case/subcases' , :label => 'SubCases'} if module_enabled?('subcases')
    tabs<< {:name => 'case_supports', partial: 'cases/show_case/case_support' , :label => 'Case Supports'} # if module_enabled?('case_support')
    tabs<< {:name => 'notes', partial: 'cases/show_case/notes' , :label => 'Notes'} if module_enabled?('notes')
    tabs<< {:name => 'documents', partial: 'cases/show_case/documents', :label => 'Documents'} if module_enabled?('documents')
    tabs<< {:name => 'enrollments', partial: 'cases/show_case/enrollments' , :label => 'Enrollments'} if module_enabled?('enrollments')
    tabs<< {:name => 'teleconsults', partial: 'cases/show_case/teleconsults' , :label => 'Teleconsults'} if module_enabled?('teleconsults')
    tabs<< {:name => 'checklists', partial: 'cases/show_case/checklists' , :label => 'Checklists'} if module_enabled?('checklists')
    tabs<< {:name => 'transports', partial: 'cases/show_case/transports', :label => 'Transports'} if module_enabled?('transports')
    tabs<< {:name => 'measurement_records', partial: 'cases/show_case/measurement_records', :label => 'Measurements'} if module_enabled?('measurement_records')
    tabs<< {:name => 'appointments', partial: 'cases/show_case/appointments' , :label => 'Appointments'} if module_enabled?('appointments')
    tabs<< {:name => 'referrals', partial: 'cases/show_case/referrals', :label => 'Referrals'} if module_enabled?('referrals')
    tabs<< {:name => 'worker_compensations', partial: 'cases/show_case/worker_compensation', :label => 'Worker Comp'} if module_enabled?('worker_compensations')
    tabs<< {:name => 'job_applications', partial: 'cases/show_case/job_app', :label => 'Job Applications'}
  #  tabs<< {:name => 'surveys', partial: 'cases/show_case/surveys', :label => 'Surveys'} # if module_enabled?('surveys')
  #  tabs<< {:name => 'case_organizations', partial: 'cases/show_case/case_organizations', :label => 'Share Organizations'}
  #  tabs<< {:name => 'watcher', partial: 'cases/show_case/watcher', :label => 'Share Individuals'} # if module_enabled?('watchers')
    tabs
  end

  # NOTE: When rest of code updated, switch top of appointment_case_tabs with link to this
  def appt_care_plan_tab
    tabs = [ ]
    tabs<< {:name => 'needs', partial: 'cases/show_case/needs' , :label => 'Needs'} if module_enabled?('needs')
    tabs<< {:name => 'goals', partial: 'cases/show_case/goals' , :label => 'Goals'} if module_enabled?('goals')
    tabs<< {:name => 'plans', partial: 'cases/show_case/plans' , :label => 'Plans'} if module_enabled?('plans')
    tabs<< {:name => 'tasks', partial: 'cases/show_case/tasks' , :label => 'Actions'} if module_enabled?('tasks')
    tabs<< {:name => 'signatures', partial: 'cases/show_case/jsignatures', :label => 'Signatures'} if module_enabled?('jsignatures')
    tabs
  end
  
end
