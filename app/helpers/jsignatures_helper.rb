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

end