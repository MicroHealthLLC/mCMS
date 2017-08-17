module UserProfilesHelper
  def user_profiles_tab
    tabs = [
        {:name => 'core_demographic', :partial => 'user_profiles/profile_record/core_demography', :label => :core_demography},
        {:name => 'extend_demographic', :partial => 'user_profiles/profile_record/extend_demography', :label => :extend_demography},
        {:name => 'related_client', :partial => 'user_profiles/profile_record/related_client', :label => :related_client}
    ]
    if @languages
      tabs<<  {:name => 'languages', :partial => 'user_profiles/profile_record/languages', :label => :languages}
    end
    if @contacts
      tabs<<  {:name => 'contact', :partial => 'user_profiles/profile_record/contact', :label => :contact}
    end
    if @affiliations
      tabs<<  {:name => 'affiliation', :partial => 'user_profiles/profile_record/affiliation', :label => :affiliation}
    end
    if @user_insurances
      tabs<<  {:name => 'user_insurance', :partial => 'user_profiles/profile_record/user_insurance', :label => :user_insurance}
    end
    if @documents
      tabs<<  {:name => 'document', :partial => 'user_profiles/profile_record/document', :label => :document}
    end
    if @jsignatures
      tabs<<  {:name => 'signature', :partial => 'user_profiles/profile_record/signature', :label => :signature}
    end
    tabs
  end

  def occupational_record_tab
    tabs = [ ]
    if @educations
      tabs<<  {:name => 'education', :partial => 'user_profiles/occupational_record/education', :label => :education}
    end

    if @other_skills
      tabs<<  {:name => 'other_skill', :partial => 'user_profiles/occupational_record/other_skill', :label => :other_skill}
    end

    if @certifications
      tabs<<  {:name => 'certification', :partial => 'user_profiles/occupational_record/certification', :label => :certification}
    end

    if @clearances
      tabs<<  {:name => 'clearance', :partial => 'user_profiles/occupational_record/clearence', :label => :clearance}
    end

    if @positions
      tabs<<  {:name => 'position', :partial => 'user_profiles/occupational_record/position', :label => :position}
    end

    if @injuries
      tabs<<  {:name => 'injuries', :partial => 'user_profiles/occupational_record/injuries', :label => :injuries}
    end

    if @worker_compensations
      tabs<<  {:name => 'worker_compensation', :partial => 'user_profiles/occupational_record/worker_compensation', :label => :worker_compensation}
    end

    if @job_applications
      tabs<<  {:name => 'job_application', :partial => 'user_profiles/occupational_record/job_application', :label => :job_application}
    end

    if @resumes
      tabs<<  {:name => 'resume', :partial => 'user_profiles/occupational_record/resume', :label => :resume}
    end

    tabs
  end
end
