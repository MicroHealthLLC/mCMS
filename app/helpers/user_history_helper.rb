module UserHistoryHelper
  def medical_record_tab
    tabs = []
    if @admissions
      tabs<<  {:name => 'admission', :partial => 'user_history/medical_record/admission', :label => :admission}
    end
    if @problem_lists
      tabs<<  {:name => 'problem_list', :partial => 'user_history/medical_record/problem_list', :label => :problem_list}
    end
    if @health_care_facilities
      tabs<<  {:name => 'health_care_facility', :partial => 'user_history/medical_record/health_care_facility', :label => :health_care_facility}
    end
    if @surgicals
      tabs<<  {:name => 'surgical', :partial => 'user_history/medical_record/surgical', :label => :surgical}
    end
    if @medicals
      tabs<<  {:name => 'medical', :partial => 'user_history/medical_record/medical', :label => :medical}
    end
    if @medications
      tabs<<  {:name => 'medication', :partial => 'user_history/medical_record/medication', :label => :medication}
    end
    if @behavioral_risks
      tabs<<  {:name => 'behavioral_risk', :partial => 'user_history/medical_record/behavioral_risk', :label => :behavioral_risk}
    end
    if @family_histories
      tabs<<  {:name => 'family_history', :partial => 'user_history/medical_record/family_history', :label => :family_history}
    end
    if @immunizations
      tabs<<  {:name => 'immunization', :partial => 'user_history/medical_record/immunization', :label => :immunization}
    end
    if @allergies
      tabs<<  {:name => 'allergy', :partial => 'user_history/medical_record/allergy', :label => :allergy}
    end
    if @laboratory_examinations
      tabs<<  {:name => 'Laboratory', :partial => 'user_history/medical_record/laboratory_examination', :label => :laboratory_examination}
    end
    if @radiologic_examinations
      tabs<<  {:name => 'Radiology', :partial => 'user_history/medical_record/radiologic_examination', :label => :radiologic_examination}
    end

    tabs
  end

  def socioeconomic_record_tab
    tabs = []
    if @daily_livings
      tabs<<  {:name => 'daily_living', :partial => 'user_history/socio_record/daily_living', :label => :daily_living}
    end
    if @socioeconomics
      tabs<<  {:name => 'socioeconomic', :partial => 'user_history/socio_record/socioeconomic', :label => :socioeconomic}
    end
    if @environment_risks
      tabs<<  {:name => 'environment_risk', :partial => 'user_history/socio_record/environment_risk', :label => :environment_risk}
    end
    if @housings
      tabs<<  {:name => 'housing', :partial => 'user_history/socio_record/housing', :label => :housing}
    end
    if @financials
      tabs<<  {:name => 'financial', :partial => 'user_history/socio_record/financial', :label => :financial}
    end
    if @legals
      tabs<<  {:name => 'legal', :partial => 'user_history/socio_record/legal', :label => :legal}
    end
    if @transportations
      tabs<<  {:name => 'transportation', :partial => 'user_history/socio_record/transportation', :label => :transportation}
    end
    if @other_histories
      tabs<<  {:name => 'other_history', :partial => 'user_history/socio_record/other_history', :label => :other_history}
    end
    tabs
  end
end
