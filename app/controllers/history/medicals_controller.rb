class MedicalsController < UserHistoryController
  add_breadcrumb I18n.t(:medicals), :medicals_path
  before_action :set_medical, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /medicals
  # GET /medicals.json
  def index
    @medicals = Medical.visible
  end

  # GET /medicals/1
  # GET /medicals/1.json
  def show
  end

  # GET /medicals/new
  def new
    @medical = Medical.new(user_id: User.current.id)
  end

  # GET /medicals/1/edit
  def edit
  end

  # POST /medicals
  # POST /medicals.json
  def create
    @medical = Medical.new(medical_params)

    respond_to do |format|
      if @medical.save
        format.html { redirect_to @medical, notice: 'Medical was successfully created.' }
        format.json { render :show, status: :created, location: @medical }
      else
        format.html { render :new }
        format.json { render json: @medical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicals/1
  # PATCH/PUT /medicals/1.json
  def update
    respond_to do |format|
      if @medical.update(medical_params)
        format.html { redirect_to @medical, notice: 'Medical was successfully updated.' }
        format.json { render :show, status: :ok, location: @medical }
      else
        format.html { render :edit }
        format.json { render json: @medical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicals/1
  # DELETE /medicals/1.json
  def destroy
    @medical.destroy
    respond_to do |format|
      format.html { redirect_to medicals_url, notice: 'Medical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_medical
    @medical = Medical.find(params[:id])
    add_breadcrumb @medical, @medical
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def medical_params
    params.require(:medical).permit(Medical.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @medical.can?(:edit_medicals, :manage_medicals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @medical.can?(:delete_medicals, :manage_medicals, :manage_roles)
  end

end
