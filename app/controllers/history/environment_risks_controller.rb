class EnvironmentRisksController < UserHistoryController
  add_breadcrumb I18n.t(:environment_risks), :environment_risks_path
  before_action :set_environment_risk, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /environment_risks
  # GET /environment_risks.json
  def index
    scope = EnvironmentRisk.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end

    @environment_risks = scope
  end

  # GET /environment_risks/1
  # GET /environment_risks/1.json
  def show
  end

  # GET /environment_risks/new
  def new
    @environment_risk = EnvironmentRisk.new(user_id: User.current.id,
                                            date_started: Date.today)
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
        format.html { redirect_to @environment_risk, notice: 'EnvironmentRisk was successfully created.' }
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
        format.html { redirect_to @environment_risk, notice: 'EnvironmentRisk was successfully updated.' }
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
      format.html { redirect_to environment_risks_url, notice: 'EnvironmentRisk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_environment_risk
    @environment_risk = EnvironmentRisk.find(params[:id])
    add_breadcrumb @environment_risk, @environment_risk
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def environment_risk_params
    params.require(:environment_risk).permit(EnvironmentRisk.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @environment_risk.can?(:edit_environment_risks, :manage_environment_risks, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @environment_risk.can?(:delete_environment_risks, :manage_environment_risks, :manage_roles)
  end

end
