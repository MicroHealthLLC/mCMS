class TransportsController  <  UserCasesController
  add_breadcrumb I18n.t(:transports), :transports_path
  before_action :set_transport, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /transports
  # GET /transports.json
  def index
    @transports = Transport.visible
  end

  # GET /transports/1
  # GET /transports/1.json
  def show
  end

  # GET /transports/new
  def new
    @transport = Transport.new(user_id: User.current.id, case_id: params[:case_id])
  end

  # GET /transports/1/edit
  def edit
  end

  # POST /transports
  # POST /transports.json
  def create
    @transport = Transport.new(transport_params)

    respond_to do |format|
      if @transport.save
        format.html { redirect_to @transport, notice: 'Transport was successfully created.' }
        format.json { render :show, status: :created, location: @transport }
      else
        format.html { render :new }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transports/1
  # PATCH/PUT /transports/1.json
  def update
    respond_to do |format|
      if @transport.update(transport_params)
        format.html { redirect_to @transport, notice: 'Transport was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport }
      else
        format.html { render :edit }
        format.json { render json: @transport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transports/1
  # DELETE /transports/1.json
  def destroy
    @transport.destroy
    respond_to do |format|
      format.html { redirect_to transports_url, notice: 'Transport was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transport
    @transport = Transport.find(params[:id])
    @case = @transport.case
    add_breadcrumb @transport, @transport
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transport_params
    params.require(:transport).permit(Transport.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @transport.can?(:edit_transports, :manage_transports, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @transport.can?(:delete_transports, :manage_transports, :manage_roles)
  end

end
