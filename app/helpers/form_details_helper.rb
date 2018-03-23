module FormDetailsHelper
  def form_detail_back_url
    case @formular.placement.to_i
      when 1 then '/profile_record#tabs-forms'
      when 2 then '/occupation_record#tabs-forms'
      when 3 then '/medical_record#tabs-forms'
      when 4 then '/socioeconomic_record#tabs-forms'
      when 5 then '/cases'
      else :back
    end
  end
end