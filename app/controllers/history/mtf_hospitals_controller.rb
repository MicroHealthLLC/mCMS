class MtfHospitalsController < UserHistoryController
  add_breadcrumb I18n.t(:mtf_hospitals), :mtf_hospitals_path
  before_action :set_mtf_hospital, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /mtf_hospitals
  # GET /mtf_hospitals.json
  def index
    scope = MtfHospital.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @mtf_hospitals = scope
  end

  # GET /mtf_hospitals/1
  # GET /mtf_hospitals/1.json
  def show
  end

  # GET /mtf_hospitals/new
  def new
    @mtf_hospital = MtfHospital.new(user_id: User.current.id)
  end

  # GET /mtf_hospitals/1/edit
  def edit
  end

  # POST /mtf_hospitals
  # POST /mtf_hospitals.json
  def create
    @mtf_hospital = MtfHospital.new(mtf_hospital_params)

    respond_to do |format|
      if @mtf_hospital.save
        format.html { redirect_to @mtf_hospital, notice: 'MtfHospital was successfully created.' }
        format.json { render :show, status: :created, location: @mtf_hospital }
      else
        format.html { render :new }
        format.json { render json: @mtf_hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mtf_hospitals/1
  # PATCH/PUT /mtf_hospitals/1.json
  def update
    respond_to do |format|
      if @mtf_hospital.update(mtf_hospital_params)
        format.html { redirect_to @mtf_hospital, notice: 'MtfHospital was successfully updated.' }
        format.json { render :show, status: :ok, location: @mtf_hospital }
      else
        format.html { render :edit }
        format.json { render json: @mtf_hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mtf_hospitals/1
  # DELETE /mtf_hospitals/1.json
  def destroy
    @mtf_hospital.destroy
    respond_to do |format|
      format.html { redirect_to mtf_hospitals_url, notice: 'MtfHospital was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mtf_hospital
    @mtf_hospital = MtfHospital.find(params[:id])
    add_breadcrumb @mtf_hospital, @mtf_hospital
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mtf_hospital_params
    params.require(:mtf_hospital).permit(MtfHospital.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @mtf_hospital.can?(:edit_mtf_hospitals, :manage_mtf_hospitals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @mtf_hospital.can?(:delete_mtf_hospitals, :manage_mtf_hospitals, :manage_roles)
  end

end
