class SocialMediaController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action :set_extend_demography
  before_action :authorize

  def new
    @social_media = @extend_demography.social_media.build
  end

  def create
    @social_media = SocialMedium.new(social_media_params)
    @social_media.extend_demography_id = @extend_demography.id
    if @social_media.save
      redirect_to @url_back
    else
      render :new
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_extend_demography
    @extend_demography = ExtendDemography.find(params[:extend_demography_id])
    @url_back = url_back
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def authorize
    true
  end

  def social_media_params
    params.require(:social_medium).permit(SocialMedium.safe_attributes)
  end

  def url_back
    if @extend_demography.department_id
      departments_path
    elsif @extend_demography.contact_id
      contacts_url
    elsif @extend_demography.organization_id
      organizations_path
    elsif @extend_demography.affiliation_id
      affiliations_path
    elsif @extend_demography.insurance_id
      insurances_path
    elsif @extend_demography.case_support_id
      case_support_path
    elsif User.current != User.current_user
      '/profile_record#tabs-extend_demographic'
    else
      if  User.current.can?(:manage_roles)
        if @user != User.current
          user_path(@user) + '#tabs-extend_demographic'
        else
           '/users/edit#tabs-extend_demographic'
        end
      else
        '/profile_record#tabs-extend_demographic'
      end
    end
  end


end
