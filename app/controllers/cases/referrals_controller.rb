class ReferralsController < UserCasesController
  add_breadcrumb I18n.t(:referrals), :referrals_path
  before_action :set_referral, only: [:links, :add_referral, :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /referrals
# GET /referrals.json
  def index
    scope =  Referral.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.opened
            end

    @referrals = scope
  end

  def links
    @referrals = @referral.referral_children
    @available_referrals = @referral.available_referrals
  end


  def add_referral
    respond_to do |format|
      format.js{
        @referral_id = params[:referral_id]
        r = @referral.referral_relation_children.where(referral_child_id: @referral_id)
        if r.present?
          r.delete_all
        else
          @referral_child = Referral.find(@referral_id)
          @available_referrals = @referral.available_referrals
          if @available_referrals.include?(@referral_child)
            ReferralRelation.create(referral_child_id:  @referral_child.id, referral_parent_id: @referral.id )
          end
        end
      }
    end
  end

# GET /referrals/1
# GET /referrals/1.json
  def show
  end

# GET /referrals/new
  def new
    @referral = Referral.new(user_id: User.current.id,
                             referred_to_id: User.current_user.id,
                             case_id: params[:related_to])
  end

# GET /referrals/1/edit
  def edit
  end

# POST /referrals
# POST /referrals.json
  def create
    @referral = Referral.new(referral_params)
    org_id = if organization = Organization.where(name: params[:client_organization]).first
               ClientOrganization.where(organization_id: organization.id).first_or_create
               organization.id
             else
               ClientOrganization.where(name: params[:client_organization]).first_or_create.id
             end

    @referral.referred_to_id = org_id
    respond_to do |format|
      if @referral.save
        set_link_to_appointment(@referral)
        format.html { redirect_to @referral, notice: 'Referral was successfully created.' }
        format.json { render :show, status: :created, location: @referral }
      else
        format.html { render :new }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /referrals/1
# PATCH/PUT /referrals/1.json
  def update
    org_id = if organization = Organization.where(name: params[:client_organization]).first
               ClientOrganization.where(organization_id: organization.id).first_or_create.id
             else
               ClientOrganization.where(name: params[:client_organization]).first_or_create.id
             end

    @referral.referred_to_id = org_id

    respond_to do |format|
      if @referral.update(referral_params)
        format.html { redirect_to @referral, notice: 'Referral was successfully updated.' }
        format.json { render :show, status: :ok, location: @referral }
      else
        format.html { render :edit }
        format.json { render json: @referral.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /referrals/1
# DELETE /referrals/1.json
  def destroy
    @referral.destroy
    respond_to do |format|
      format.html { redirect_to referrals_url, notice: 'Referral was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_organization
    q = params[:term]

    scope = Organization.where('name LIKE ?', "#{q}%")
    scope2 = ClientOrganization.where('name LIKE ?', "#{q}%").where(organization_id: nil)

    result = []
    scope.each do |s|
      result<< {id: s.name, name: s.name, label: s.name,  }
    end
     scope2.each do |s|
      result<< {id: s.name, name: s.name, label: s.name,  }
    end
    render json: result
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_referral
    @referral = Referral.includes(:user, :referred_by, :referred_to).find(params[:id])
    add_breadcrumb @referral.to_s, @referral
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def referral_params
    params.require(:referral).permit(Referral.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @referral.can?(:edit_referrals, :manage_referrals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @referral.can?(:delete_referrals, :manage_referrals, :manage_roles)
  end
end

