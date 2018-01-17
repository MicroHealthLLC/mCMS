class BehavioralRisksController < UserHistoryController
  add_breadcrumb 'Health History', '/medical_record'
  add_breadcrumb I18n.t(:behavioral_risks), :behavioral_risks_path
  before_action :set_behavioral_risk, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /behavioral_risks
  # GET /behavioral_risks.json
  def index
    respond_to do |format|
      format.html{  redirect_to medical_record_path + "#tabs-behavioral_risk" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = BehavioralRiskDatatable.new(view_context, options).as_json
        send_data BehavioralRisk.to_csv(json[:data]), filename: "Behavioral-risk-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: BehavioralRiskDatatable.new(view_context,options)
      }
    end
  end

  # GET /behavioral_risks/1
  # GET /behavioral_risks/1.json
  def show
  end

  # GET /behavioral_risks/new
  def new
    @behavioral_risk = BehavioralRisk.new(user_id: User.current.id,
                                          date_started: Date.today)
  end

  # GET /behavioral_risks/1/edit
  def edit
  end

  # POST /behavioral_risks
  # POST /behavioral_risks.json
  def create
    @behavioral_risk = BehavioralRisk.new(behavioral_risk_params)

    respond_to do |format|
      if @behavioral_risk.save
        format.html { redirect_to behavioral_risks_url, notice: 'BehavioralRisk was successfully created.' }
      #  format.json { render :show, status: :created, location: @behavioral_risk }
      else
        format.html { render :new }
        format.json { render json: @behavioral_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /behavioral_risks/1
  # PATCH/PUT /behavioral_risks/1.json
  def update
    respond_to do |format|
      if @behavioral_risk.update(behavioral_risk_params)
        format.html { redirect_to behavioral_risks_url, notice: 'BehavioralRisk was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @behavioral_risk }
      else
        format.html { render :edit }
        format.json { render json: @behavioral_risk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /behavioral_risks/1
  # DELETE /behavioral_risks/1.json
  def destroy
    @behavioral_risk.destroy
    respond_to do |format|
      format.html { redirect_to behavioral_risks_url, notice: 'BehavioralRisk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_behavioral_risk
    @behavioral_risk = BehavioralRisk.find(params[:id])
    add_breadcrumb @behavioral_risk, @behavioral_risk
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def behavioral_risk_params
    params.require(:behavioral_risk).permit(BehavioralRisk.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @behavioral_risk.can?(:edit_behavioral_risks, :manage_behavioral_risks, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @behavioral_risk.can?(:delete_behavioral_risks, :manage_behavioral_risks, :manage_roles)
  end

end
