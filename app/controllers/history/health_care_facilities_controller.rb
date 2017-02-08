class HealthCareFacilitiesController < UserHistoryController
  add_breadcrumb I18n.t(:health_care_facilities), :health_care_facilities_path
  before_action :set_health_care_facility, only: [:show, :edit, :update, :destroy]


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /health_care_facilities
  # GET /health_care_facilities.json
  def index
    @health_care_facilities = HealthCareFacility.visible
  end

  # GET /health_care_facilities/1
  # GET /health_care_facilities/1.json
  def show
  end

  # GET /health_care_facilities/new
  def new
    @health_care_facility = HealthCareFacility.new(user_id: User.current.id)
  end

  # GET /health_care_facilities/1/edit
  def edit
  end

  # POST /health_care_facilities
  # POST /health_care_facilities.json
  def create
    @health_care_facility = HealthCareFacility.new(health_care_facility_params)

    respond_to do |format|
      if @health_care_facility.save
        format.html { redirect_to @health_care_facility, notice: 'Health care facility was successfully created.' }
        format.json { render :show, status: :created, location: @health_care_facility }
      else
        format.html { render :new }
        format.json { render json: @health_care_facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /health_care_facilities/1
  # PATCH/PUT /health_care_facilities/1.json
  def update
    respond_to do |format|
      if @health_care_facility.update(health_care_facility_params)
        format.html { redirect_to @health_care_facility, notice: 'Health care facility was successfully updated.' }
        format.json { render :show, status: :ok, location: @health_care_facility }
      else
        format.html { render :edit }
        format.json { render json: @health_care_facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /health_care_facilities/1
  # DELETE /health_care_facilities/1.json
  def destroy
    @health_care_facility.destroy
    respond_to do |format|
      format.html { redirect_to health_care_facilities_url, notice: 'Health care facility was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_health_care_facility
    @health_care_facility = HealthCareFacility.find(params[:id])
    add_breadcrumb @health_care_facility, @health_care_facility
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def health_care_facility_params
    params.require(:health_care_facility).permit(HealthCareFacility.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @health_care_facility.can?(:edit_health_care_facilities, :manage_health_care_facilities, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @health_care_facility.can?(:delete_health_care_facilities, :manage_health_care_facilities, :manage_roles)
  end

end
