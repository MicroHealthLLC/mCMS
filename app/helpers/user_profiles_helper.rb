module UserProfilesHelper
  def user_profiles_tab
    tabs = [
        {:name => 'core_demographic', :partial => 'user_profiles/profile_record/core_demography', :label => :core_demography},
        {:name => 'extend_demographic', :partial => 'user_profiles/profile_record/extend_demography', :label => :extend_demography},
        {:name => 'related_client', :partial => 'user_profiles/profile_record/related_client', :label => 'Related Clients'}
    ]
    tabs << {:name => 'identification', :partial => 'devise/registrations/shared/identification_form', :label => 'Identifications'}

    if @languages
      tabs<<  {:name => 'languages', :partial => 'user_profiles/profile_record/languages', :label => :languages}
    end
    if @contacts
      tabs<<  {:name => 'contact', :partial => 'user_profiles/profile_record/contact', :label => 'Contacts'}
    end
    if @affiliations
      tabs<<  {:name => 'affiliation', :partial => 'user_profiles/profile_record/affiliation', :label => 'Affiliations'}
    end
    if @user_insurances
      tabs<<  {:name => 'user_insurance', :partial => 'user_profiles/profile_record/user_insurance', :label => 'Insurances'}
    end
    if @documents
      tabs<<  {:name => 'document', :partial => 'user_profiles/profile_record/document', :label => 'Documents'}
    end
    if @jsignatures
      tabs<<  {:name => 'signature', :partial => 'user_profiles/profile_record/signature', :label => 'Signatures'}
    end
    tabs << {:name => 'password', :partial => 'devise/registrations/shared/password', :label => :password}
    if can?(:manage_roles, :manage_user_job_details, :manage_organizations)
      tabs << {:name => 'organization', :partial => 'devise/registrations/shared/job_detail', :label => :organization}
    end

    if can?(:manage_roles, :manage_form_details, :view_form_details)
      if Formular.from_organization.for(Formular::PROFILE_RECORD).any?
        tabs << {:name => 'forms', :partial => 'formulars/formular', :label => 'forms', formulars: Formular.from_organization.for(Formular::PROFILE_RECORD) }
      end
    end

    tabs
  end

  def occupational_record_tab
    tabs = [ ]
    if @educations
      tabs<<  {:name => 'education', :partial => 'user_profiles/occupational_record/education', :label => :education}
    end

    if @other_skills
      tabs<<  {:name => 'other_skill', :partial => 'user_profiles/occupational_record/other_skill', :label => 'Skills'}
    end

    if @certifications
      tabs<<  {:name => 'certification', :partial => 'user_profiles/occupational_record/certification', :label => 'Certifications'}
    end

    if @clearances
      tabs<<  {:name => 'clearance', :partial => 'user_profiles/occupational_record/clearence', :label => 'Clearances'}
    end

    if @positions
      tabs<<  {:name => 'position', :partial => 'user_profiles/occupational_record/position', :label => 'Positions'}
    end

    if @injuries
      tabs<<  {:name => 'injuries', :partial => 'user_profiles/occupational_record/injuries', :label => :injuries}
    end

    if @resumes
      tabs<<  {:name => 'resume', :partial => 'user_profiles/occupational_record/resume', :label => 'Resumes'}
    end

    if @military_histories
      tabs<<  {:name => 'military_history', :partial => 'user_profiles/occupational_record/military_history', :label => :military_history}
    end

    if @job_apps
      tabs<<  {:name => 'job_applications', :partial => 'cases/show_case/job_app', :label => 'Job Applications'}
    end
    if can?(:manage_roles, :manage_form_details, :view_form_details)
      if Formular.from_organization.for(Formular::OCCUPATION_RECORD).any?
        tabs << {:name => 'forms', :partial => 'formulars/formular', :label => 'forms', formulars: Formular.from_organization.for(Formular::OCCUPATION_RECORD) }
      end
    end


    tabs
  end
end
