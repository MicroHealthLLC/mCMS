class EnvironmentRisksController < ApplicationController
  before_action :set_environment_risk, only: [:show, :edit, :update, :destroy]

  # GET /environment_risks
  # GET /environment_risks.json
  def index
    @environment_risks = EnvironmentRisk.all
  end

  # GET /environment_risks/1
  # GET /environment_risks/1.json
  def show
  end

  # GET /environment_risks/new
  def new
    @environment_risk = EnvironmentRisk.new
  end

  # GET /environment_risks/1/edit
  def edit
  end

  # POST /environment_risks
  # POST /environment_risks.json
  def create
    @environment_risk = EnvironmentRisk.new(environment_risk_params)

    respond_to do |format|
      if @environment_risk.save
        format.html { redirect_to @environment_risk, notice: 'Environment risk was successfully created.' }
        format.json { render :show, status: :created, location: @environment_risk }
      else
        format.html { render :new }
        format.json { render json: @environment_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /environment_risks/1
  # PATCH/PUT /environment_risks/1.json
  def update
    respond_to do |format|
      if @environment_risk.update(environment_risk_params)
        format.html { redirect_to @environment_risk, notice: 'Environment risk was successfully updated.' }
        format.json { render :show, status: :ok, location: @environment_risk }
      else
        format.html { render :edit }
        format.json { render json: @environment_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /environment_risks/1
  # DELETE /environment_risks/1.json
  def destroy
    @environment_risk.destroy
    respond_to do |format|
      format.html { redirect_to environment_risks_url, notice: 'Environment risk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_environment_risk
      @environment_risk = EnvironmentRisk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def environment_risk_params
      params.require(:environment_risk).permit(:user_id, :icdcm_code_id, :date_started, :date_ended, :environment_status_id, :environment_type_id, :description)
    end
end
