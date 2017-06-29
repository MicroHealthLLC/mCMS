class MeasurementRecordsController < UserCasesController
  add_breadcrumb I18n.t('home'), :root_path
  add_breadcrumb 'Measurements', :measurement_records_path
  before_action :authenticate_user!
  before_action :authorize

  before_action :set_measurement_record, only: [:show, :edit, :update, :destroy]

  # GET /measurement_records
  # GET /measurement_records.json
  def index
    respond_to do |format|
      format.html{
        @measurement_records = MeasurementRecord.visible
      }
      format.js{
        @measurement_record = MeasurementRecord.new(measurement_params)
        @measurement_record.user_id = User.current.id
        @measurement_record.age = User.current.age
        @measurement_record.height = User.current.height
        @measurement_record.weight = User.current.weight
        @measurement_record.gender_id = User.current.gender.try(:id)
      }

      format.pdf{@measurement_records = MeasurementRecord.visible}
    end
  end

  # GET /measurement_records/1
  # GET /measurement_records/1.json
  def show
  end

  # GET /measurement_records/new
  def new
    @measurement_record = MeasurementRecord.new(measurement_params)
    @measurement_record.user_id = User.current.id
  end

  # GET /measurement_records/1/edit
  def edit
  end

  # POST /measurement_records
  # POST /measurement_records.json
  def create
    measurement_count = params['measurement_count'].to_i
    measure_params = measurement_record_params
    (0..measurement_count).each do |i|
      measure_params.merge!( {
                                 component_id: params["component_id_#{i}"],
                                 measure: params["measure_#{i}"],
                                 recorded_by_id: params["recorded_by_id_#{i}"],
                                 date_time: params["date_time_#{i}"],
                                 measurement_status_id: params["measurement_status_id_#{i}"],
                                 measured_by: params["measured_by_#{i}"],
                                 flag: params["flag_#{i}"]
                             })
      @measurement_record = MeasurementRecord.new(measure_params).save
    end
    respond_to do |format|
      format.html { redirect_to measurement_records_path, notice: 'Measurement record was successfully created.' }
      format.json { render :show, status: :created, location: @measurement_record }

    end
  end

  # PATCH/PUT /measurement_records/1
  # PATCH/PUT /measurement_records/1.json
  def update
    respond_to do |format|
      if @measurement_record.update(measurement_record_params)
        format.html { redirect_to @measurement_record, notice: 'Measurement record was successfully updated.' }
        format.json { render :show, status: :ok, location: @measurement_record }
      else
        format.html { render :edit }
        format.json { render json: @measurement_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /measurement_records/1
  # DELETE /measurement_records/1.json
  def destroy
    @measurement_record.destroy
    respond_to do |format|
      format.html { redirect_to measurement_records_url, notice: 'Measurement record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_measurement_record
    @measurement_record = MeasurementRecord.find(params[:id])
    @component = @measurement_record.component
    add_breadcrumb @measurement_record, @measurement_record
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def measurement_record_params
    params.require(:measurement_record).permit(MeasurementRecord.safe_attributes)
  end

  def measurement_params
    params.permit(MeasurementRecord.safe_attributes)
  end
end