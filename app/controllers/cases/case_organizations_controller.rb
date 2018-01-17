class CaseOrganizationsController < UserCasesController
   before_action :set_case_organization, only: [:links, :add_goal, :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


   def index
     @case_organizations = CaseOrganization.where(case_id: @cases_for_btn.pluck(:id)).
         includes(:organization).references(:organization)
     respond_to do |format|
       format.html{}
       format.pdf{}
     end
   end

  # GET /case_organizations/1
  # GET /case_organizations/1.json
  def show
    respond_to do |format|
      format.html{}
      format.pdf{}
      format.js{
      }
    end
  end
  
  # GET /case_organizations/new
  def new
    @case = Case.visible.find(params[:case_id])
    @case_organization = CaseOrganization.new(case_id: @case.id)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # GET /case_organizations/1/edit
  def edit
  end

  # POST /case_organizations
  # POST /case_organizations.json
  def create
    @case_organization = CaseOrganization.new(case_organization_params)

    respond_to do |format|
      if @case_organization.save
        set_link_to_appointment(@case_organization)
        format.html { redirect_to case_organizations_url, notice: 'CaseOrganization was successfully created.' }
      #  format.json { render :show, status: :created, location: @case_organization }
      else
        format.html { render :new }
        format.json { render json: @case_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /case_organizations/1
  # PATCH/PUT /case_organizations/1.json
  def update
    respond_to do |format|
      if @case_organization.update(case_organization_params)
        format.html { redirect_to case_organizations_url, notice: 'Case Organization was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @case_organization }
      else
        format.html { render :edit }
        format.json { render json: @case_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_organizations/1
  # DELETE /case_organizations/1.json
  def destroy
    @case_organization.destroy
    respond_to do |format|
      format.html { redirect_to case_organizations_url, notice: 'Case Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_case_organization
    @case_organization = CaseOrganization.find(params[:id])
    @case = @case_organization.case
    add_breadcrumb @case, @case
    add_breadcrumb @case_organization, case_organization_path(@case_organization)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def case_organization_params
    params.require(:case_organization).permit(CaseOrganization.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless User.current_user.can?(:edit_case_organizations, :manage_case_organizations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless User.current_user.can?(:delete_case_organizations, :manage_case_organizations, :manage_roles)
  end
end
