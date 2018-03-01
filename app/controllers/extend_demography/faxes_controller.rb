class FaxesController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action :set_extend_demography
  before_action :authorize

  def new
    @faxe = @extend_demography.faxes.build
  end

  def create
    @faxe = Fax.new(email_params)
    @faxe.extend_demography_id = @extend_demography.id
    if @faxe.save
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

  def email_params
    params.require(:fax).permit(Fax.safe_attributes)
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
