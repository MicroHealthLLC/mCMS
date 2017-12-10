class MedicationsController < UserHistoryController
  add_breadcrumb I18n.t(:medications), :medications_path
  before_action :set_medication, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /medications
  # GET /medications.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path + "#tabs-medication" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = MedicationDatatable.new(view_context, options).as_json
        send_data Medication.to_csv(json[:data]), filename: "Medication-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: MedicationDatatable.new(view_context,options)
      }
    end
  end

  # GET /medications/1
  # GET /medications/1.json
  def show
  end

  # GET /medications/new
  def new
    @medication = Medication.new(user_id: User.current.id)
  end

  # GET /medications/1/edit
  def edit
  end

  # POST /medications
  # POST /medications.json
  def create
    @medication = Medication.new(medication_params)

    respond_to do |format|
      if @medication.save
        format.html { redirect_to medication_url(@medication), notice: 'Medication was successfully created.' }
        format.json { render :show, status: :created, location: @medication }
      else
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medications/1
  # PATCH/PUT /medications/1.json
  def update
    respond_to do |format|
      if @medication.update(medication_params)
        format.html { redirect_to medication_url(@medication), notice: 'Medication was successfully updated.' }
        format.json { render :show, status: :ok, location: @medication }
      else
        format.html { render :edit }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.json
  def destroy
    @medication.destroy
    respond_to do |format|
      format.html { redirect_to medications_url, notice: 'Medication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_medication
    @medication = Medication.find(params[:id])
    add_breadcrumb @medication, @medication
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def medication_params
    params.require(:medication).permit(Medication.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @medication.can?(:edit_medications, :manage_medications, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @medication.can?(:delete_medications, :manage_medications, :manage_roles)
  end

end
