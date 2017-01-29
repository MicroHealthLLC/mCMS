class AffiliationsController < UserProfilesController
  add_breadcrumb I18n.t(:affiliations), :affiliations_path
  before_action :set_affiliation, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /affiliations
  # GET /affiliations.json
  def index
    @affiliations = Affiliation.visible
  end

  # GET /affiliations/1
  # GET /affiliations/1.json
  def show
  end

  # GET /affiliations/new
  def new
    @affiliation = Affiliation.new user_id: User.current.id
  end

  # GET /affiliations/1/edit
  def edit
  end

  # POST /affiliations
  # POST /affiliations.json
  def create
    @affiliation = Affiliation.new(affiliation_params)

    respond_to do |format|
      if @affiliation.save
        format.html { redirect_to @affiliation, notice: 'Affiliation was successfully created.' }
        format.json { render :show, status: :created, location: @affiliation }
      else
        format.html { render :new }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /affiliations/1
  # PATCH/PUT /affiliations/1.json
  def update
    respond_to do |format|
      if @affiliation.update(affiliation_params)
        format.html { redirect_to @affiliation, notice: 'Affiliation was successfully updated.' }
        format.json { render :show, status: :ok, location: @affiliation }
      else
        format.html { render :edit }
        format.json { render json: @affiliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affiliations/1
  # DELETE /affiliations/1.json
  def destroy
    @affiliation.destroy
    respond_to do |format|
      format.html { redirect_to affiliations_url, notice: 'Affiliation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_affiliation
    @affiliation = Affiliation.find(params[:id])
    add_breadcrumb @affiliation, @affiliation
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def affiliation_params
    params.require(:affiliation).permit(Affiliation.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @affiliation.can?(:view_affiliations, :manage_affiliations, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @affiliation.can?(:edit_affiliations, :manage_affiliations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @affiliation.can?(:delete_affiliations, :manage_affiliations, :manage_roles)
  end

end
