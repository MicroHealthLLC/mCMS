class MeasurementRecordsController < ApplicationController
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
        if @component = @measurement_record.component
          @measurement_record.measured_by = @measurement_record.component.measured_by
        end
      }
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
    @measurement_record = MeasurementRecord.new(measurement_record_params)

    respond_to do |format|
      if @measurement_record.save
        format.html { redirect_to @measurement_record, notice: 'Measurement record was successfully created.' }
        format.json { render :show, status: :created, location: @measurement_record }
      else
        format.html { render :new }
        format.json { render json: @measurement_record.errors, status: :unprocessable_entity }
      end
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
