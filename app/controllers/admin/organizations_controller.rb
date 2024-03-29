class OrganizationsController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user
  before_action :require_admin, except: [:show]

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new(user_id: User.current.id)
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to edit_organization_path(@organization), notice: 'Organization was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    if @organization.destroy
      redirect_to organizations_url, notice: 'Organization was successfully destroyed.'
    else
      flash[:error] = @organization.errors.full_messages.join('<br/>')
      redirect_to edit_organization_url(@organization)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
      # add_breadcrumb @organization, @organization
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(Organization.safe_attributes)
    end

  def authorize_edit
    raise Unauthorized unless @organization.can?(:edit_organizations, :manage_organizations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @organization.can?(:delete_organizations, :manage_organizations, :manage_roles)
  end
end
