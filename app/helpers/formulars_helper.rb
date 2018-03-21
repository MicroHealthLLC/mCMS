module FormularsHelper

  def formular_back_url
    if User.current.can?(:manage_roles)
      '/formulars'
    else
      case @formular.placement.to_i
        when 1 then '/profile_record'
        when 2 then '/occupation_record'
        when 3 then '/medical_record'
        when 4 then '/socioeconomic_record'
        when 5 then '/cases'
        else root_path
      end
    end

  end


end
