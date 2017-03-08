class TeleconsultsController  < UserCasesController
  add_breadcrumb I18n.t(:teleconsults), :teleconsults_path
  before_action :set_teleconsult, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /teleconsults
  # GET /teleconsults.json
  def index
    scope = Teleconsult.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @teleconsults = scope
  end

  # GET /teleconsults/1
  # GET /teleconsults/1.json
  def show
  end

  # GET /teleconsults/new
  def new
    @teleconsult = Teleconsult.new(user_id: User.current.id,
                                   case_id: params[:case_id])
  end

  # GET /teleconsults/1/edit
  def edit
  end

  # POST /teleconsults
  # POST /teleconsults.json
  def create
    @teleconsult = Teleconsult.new(teleconsult_params)

    respond_to do |format|
      if @teleconsult.save
        set_link_to_appointment(@teleconsult)
        format.html { redirect_to @teleconsult, notice: 'Teleconsult was successfully created.' }
        format.json { render :show, status: :created, location: @teleconsult }
      else
        format.html { render :new }
        format.json { render json: @teleconsult.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teleconsults/1
  # PATCH/PUT /teleconsults/1.json
  def update
    respond_to do |format|
      if @teleconsult.update(teleconsult_params)
        format.html { redirect_to @teleconsult, notice: 'Teleconsult was successfully updated.' }
        format.json { render :show, status: :ok, location: @teleconsult }
      else
        format.html { render :edit }
        format.json { render json: @teleconsult.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teleconsults/1
  # DELETE /teleconsults/1.json
  def destroy
    @teleconsult.destroy
    respond_to do |format|
      format.html { redirect_to teleconsults_url, notice: 'Teleconsult was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_teleconsult
    @teleconsult = Teleconsult.find(params[:id])
    add_breadcrumb @teleconsult.to_s, @teleconsult
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teleconsult_params
    params.require(:teleconsult).permit(Teleconsult.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @teleconsult.can?(:edit_teleconsults, :manage_teleconsults, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @teleconsult.can?(:delete_teleconsults, :manage_teleconsults, :manage_roles)
  end
end
