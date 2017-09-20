class FamilyHistoriesController < UserHistoryController
  add_breadcrumb I18n.t(:family_histories), :family_histories_path
  before_action :set_family_history, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /family_histories
  # GET /family_histories.json
  def index
    redirect_to medical_record_path if request.format.to_sym == :html
    scope = FamilyHistory.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @family_histories = scope
  end

  # GET /family_histories/1
  # GET /family_histories/1.json
  def show
  end

  # GET /family_histories/new
  def new
    @family_history = FamilyHistory.new(user_id: User.current.id,
                                        :date_identified => Date.today)
  end

  # GET /family_histories/1/edit
  def edit
  end

  # POST /family_histories
  # POST /family_histories.json
  def create
    @family_history = FamilyHistory.new(family_history_params)

    respond_to do |format|
      if @family_history.save
        format.html { redirect_to @family_history, notice: 'FamilyHistory was successfully created.' }
        format.json { render :show, status: :created, location: @family_history }
      else
        format.html { render :new }
        format.json { render json: @family_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /family_histories/1
  # PATCH/PUT /family_histories/1.json
  def update
    respond_to do |format|
      if @family_history.update(family_history_params)
        format.html { redirect_to @family_history, notice: 'FamilyHistory was successfully updated.' }
        format.json { render :show, status: :ok, location: @family_history }
      else
        format.html { render :edit }
        format.json { render json: @family_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /family_histories/1
  # DELETE /family_histories/1.json
  def destroy
    @family_history.destroy
    respond_to do |format|
      format.html { redirect_to family_histories_url, notice: 'FamilyHistory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_family_history
    @family_history = FamilyHistory.find(params[:id])
    add_breadcrumb @family_history, @family_history
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def family_history_params
    params.require(:family_history).permit(FamilyHistory.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @family_history.can?(:edit_family_histories, :manage_family_histories, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @family_history.can?(:delete_family_histories, :manage_family_histories, :manage_roles)
  end

end
