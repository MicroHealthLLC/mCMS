module AppointmentsHelper
  def appointment_back_url appointment
    appointment.related_to_id ? appointment.case : appointments_path
  end

  def date_time_form(datetime)
    datetime.strftime("%Y-%m-%d %I:%M %p") if datetime
  end

  def appointment_tabs
    tabs =  [ ]
    tabs<< {:name => 'capture', :partial => 'appointments/partials/captures', :label => 'Assessment'}
    tabs<< {:name => 'disposition', :partial => 'appointments/partials/disposition', :label => 'Disposition'}
    tabs<< {:name => 'procedure', :partial => 'appointments/partials/procedure', :label => 'Procedure'}
    if module_enabled? 'billings'
      tabs<< {:name => 'billing', :partial => 'appointments/partials/billing', :label => 'Billing'}
    end
    tabs<< {:name => 'note', :partial => 'appointments/partials/notes', :label => 'Note'}
    tabs<< {:name => 'signature', :partial => 'appointments/partials/signature', :label => 'Signature'}
    tabs
  end

  def appointment_case_tabs
    tabs =  [ ]
    tabs<< {:name => 'subcases', partial: 'cases/show_case/subcases' , :label => 'Subcases'} if module_enabled?('subcases')
    tabs<< {:name => 'case_support', partial: 'cases/show_case/case_support' , :label => 'Case support'} if module_enabled?('case_supports')
    tabs<< {:name => 'notes', partial: 'cases/show_case/notes' , :label => 'Notes'} if module_enabled?('notes')
    tabs<< {:name => 'needs', partial: 'cases/show_case/needs' , :label => 'Needs'} if module_enabled?('needs')
    tabs<< {:name => 'goals', partial: 'cases/show_case/goals' , :label => 'Goals'} if module_enabled?('goals')
    tabs<< {:name => 'plans', partial: 'cases/show_case/plans' , :label => 'Plans'} if module_enabled?('plans')
    tabs<< {:name => 'tasks', partial: 'cases/show_case/tasks' , :label => 'Actions'} if module_enabled?('tasks')
    tabs<< {:name => 'documents', partial: 'cases/show_case/documents', :label => 'Documents'} if module_enabled?('documents')
    tabs<< {:name => 'enrollments', partial: 'cases/show_case/enrollments' , :label => 'Enrollments'} if module_enabled?('enrollments')
    tabs<< {:name => 'teleconsults', partial: 'cases/show_case/teleconsults' , :label => 'Teleconsults'} if module_enabled?('teleconsults')
    tabs<< {:name => 'checklists', partial: 'cases/show_case/checklists' , :label => 'checklists'} if module_enabled?('checklists')
    tabs<< {:name => 'appointments', partial: 'cases/show_case/appointments' , :label => 'Appointments'} if module_enabled?('appointments')
    tabs
  end


end
