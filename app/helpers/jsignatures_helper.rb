module JsignaturesHelper
  def redirect_url
    @owner = @jsignature.signature_owner

    if @jsignature.signature_owner_type == 'User'
      '/profile_record#tabs-signature'
    else
      if @owner.is_a? Case
        case_path(@owner) + '#tabs-signatures'
      else
        @jsignature
      end
    end
  end

  def jsignature_cancel
    @jsignature_owner = @jsignature.signature_owner
    case @jsignature.signature_owner_type
      when 'User'
        '/profile_record#tabs-signature'
      when 'Case'
        case_path(@jsignature_owner) + '#tabs-signatures'
      when 'Appointment'
        appointment_path(@jsignature_owner) + '#tabs-signatures'
      when 'UserInsurance'
        user_insurance_path(@jsignature_owner) + '#tabs-signatures'
      else
        @jsignature
    end
  end

end