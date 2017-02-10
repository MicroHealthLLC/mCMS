class DeploymentHistoriesController < UserHistoryController
  add_breadcrumb I18n.t(:deployment_histories), :deployment_histories_path
  before_action :set_deployment_history, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /deployment_histories
  # GET /deployment_histories.json
  def index
    @deployment_histories = DeploymentHistory.visible
  end

  # GET /deployment_histories/1
  # GET /deployment_histories/1.json
  def show
  end

  # GET /deployment_histories/new
  def new
    @deployment_history = DeploymentHistory.new(user_id: User.current.id)
  end

  # GET /deployment_histories/1/edit
  def edit
  end

  # POST /deployment_histories
  # POST /deployment_histories.json
  def create
    @deployment_history = DeploymentHistory.new(deployment_history_params)

    respond_to do |format|
      if @deployment_history.save
        format.html { redirect_to @deployment_history, notice: 'DeploymentHistory was successfully created.' }
        format.json { render :show, status: :created, location: @deployment_history }
      else
        format.html { render :new }
        format.json { render json: @deployment_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deployment_histories/1
  # PATCH/PUT /deployment_histories/1.json
  def update
    respond_to do |format|
      if @deployment_history.update(deployment_history_params)
        format.html { redirect_to @deployment_history, notice: 'DeploymentHistory was successfully updated.' }
        format.json { render :show, status: :ok, location: @deployment_history }
      else
        format.html { render :edit }
        format.json { render json: @deployment_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deployment_histories/1
  # DELETE /deployment_histories/1.json
  def destroy
    @deployment_history.destroy
    respond_to do |format|
      format.html { redirect_to deployment_histories_url, notice: 'DeploymentHistory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_deployment_history
    @deployment_history = DeploymentHistory.find(params[:id])
    add_breadcrumb @deployment_history, @deployment_history
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deployment_history_params
    params.require(:deployment_history).permit(DeploymentHistory.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @deployment_history.can?(:edit_deployment_histories, :manage_deployment_histories, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @deployment_history.can?(:delete_deployment_histories, :manage_deployment_histories, :manage_roles)
  end

end
