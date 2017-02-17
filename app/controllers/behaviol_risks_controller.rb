class BehaviolRisksController < ApplicationController
  before_action :set_behaviol_risk, only: [:show, :edit, :update, :destroy]

  # GET /behaviol_risks
  # GET /behaviol_risks.json
  def index
    @behaviol_risks = BehaviolRisk.all
  end

  # GET /behaviol_risks/1
  # GET /behaviol_risks/1.json
  def show
  end

  # GET /behaviol_risks/new
  def new
    @behaviol_risk = BehaviolRisk.new
  end

  # GET /behaviol_risks/1/edit
  def edit
  end

  # POST /behaviol_risks
  # POST /behaviol_risks.json
  def create
    @behaviol_risk = BehaviolRisk.new(behaviol_risk_params)

    respond_to do |format|
      if @behaviol_risk.save
        format.html { redirect_to @behaviol_risk, notice: 'Behaviol risk was successfully created.' }
        format.json { render :show, status: :created, location: @behaviol_risk }
      else
        format.html { render :new }
        format.json { render json: @behaviol_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /behaviol_risks/1
  # PATCH/PUT /behaviol_risks/1.json
  def update
    respond_to do |format|
      if @behaviol_risk.update(behaviol_risk_params)
        format.html { redirect_to @behaviol_risk, notice: 'Behaviol risk was successfully updated.' }
        format.json { render :show, status: :ok, location: @behaviol_risk }
      else
        format.html { render :edit }
        format.json { render json: @behaviol_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /behaviol_risks/1
  # DELETE /behaviol_risks/1.json
  def destroy
    @behaviol_risk.destroy
    respond_to do |format|
      format.html { redirect_to behaviol_risks_url, notice: 'Behaviol risk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_behaviol_risk
      @behaviol_risk = BehaviolRisk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def behaviol_risk_params
      params.require(:behaviol_risk).permit(:user_id, :icdcm_code_id, :date_started, :date_ended, :behavioral_risk_status_id, :behavioral_risk_type_id, :description)
    end
end
