module TimelineHelper
  def timeline_tab
    tabs = [
        {:name => 'client_profile', :partial => 'timeline/tabs/client_profile_timeline', :label => :client_profile},
        {:name => 'occupation_record', :partial => 'timeline/tabs/occupation_record_timeline', :label => :occupation_record},
        {:name => 'health_record', :partial => 'timeline/tabs/health_record_timeline', :label => :health_record},
        {:name => 'socioeconomic_record', :partial => 'timeline/tabs/socioeconomic_timeline', :label => :socioeconomic},
        {:name => 'case_record', :partial => 'timeline/tabs/case_timeline', :label => :case_record},
        {:name => 'other_record', :partial => 'timeline/tabs/other_record_timeline', :label => :other_record},

    ]
    tabs
  end

end
