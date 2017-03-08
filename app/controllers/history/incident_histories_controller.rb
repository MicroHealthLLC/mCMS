class IncidentHistoriesController < UserHistoryController
  add_breadcrumb I18n.t(:incident_histories), :incident_histories_path
  before_action :set_incident_history, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /incident_histories
  # GET /incident_histories.json
  def index
    scope = IncidentHistory.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end

    @incident_histories = scope
  end

  # GET /incident_histories/1
  # GET /incident_histories/1.json
  def show
  end

  # GET /incident_histories/new
  def new
    @incident_history = IncidentHistory.new(user_id: User.current.id)
  end

  # GET /incident_histories/1/edit
  def edit
  end

  # POST /incident_histories
  # POST /incident_histories.json
  def create
    @incident_history = IncidentHistory.new(incident_history_params)

    respond_to do |format|
      if @incident_history.save
        format.html { redirect_to @incident_history, notice: 'IncidentHistory was successfully created.' }
        format.json { render :show, status: :created, location: @incident_history }
      else
        format.html { render :new }
        format.json { render json: @incident_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incident_histories/1
  # PATCH/PUT /incident_histories/1.json
  def update
    respond_to do |format|
      if @incident_history.update(incident_history_params)
        format.html { redirect_to @incident_history, notice: 'IncidentHistory was successfully updated.' }
        format.json { render :show, status: :ok, location: @incident_history }
      else
        format.html { render :edit }
        format.json { render json: @incident_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incident_histories/1
  # DELETE /incident_histories/1.json
  def destroy
    @incident_history.destroy
    respond_to do |format|
      format.html { redirect_to incident_histories_url, notice: 'IncidentHistory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_incident_history
    @incident_history = IncidentHistory.find(params[:id])
    add_breadcrumb @incident_history, @incident_history
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def incident_history_params
    params.require(:incident_history).permit(IncidentHistory.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @incident_history.can?(:edit_incident_histories, :manage_incident_histories, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @incident_history.can?(:delete_incident_histories, :manage_incident_histories, :manage_roles)
  end

end
