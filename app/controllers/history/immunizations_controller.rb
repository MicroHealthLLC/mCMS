class ImmunizationsController < UserHistoryController
  add_breadcrumb I18n.t(:immunizations), :immunizations_path
  before_action :set_immunization, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /immunizations
  # GET /immunizations.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path }
      format.js{}
      format.pdf{}
      format.csv{
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = ImmunizationDatatable.new(view_context, options).as_json
        send_data Immunization.to_csv(json[:data]), filename: "Immunization-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: ImmunizationDatatable.new(view_context,options)
      }
    end
  end

  # GET /immunizations/1
  # GET /immunizations/1.json
  def show
  end

  # GET /immunizations/new
  def new
    @immunization = Immunization.new(user_id: User.current.id)
  end

  # GET /immunizations/1/edit
  def edit
  end

  # POST /immunizations
  # POST /immunizations.json
  def create
    @immunization = Immunization.new(immunization_params)

    respond_to do |format|
      if @immunization.save
        format.html { redirect_to @immunization, notice: 'Immunization was successfully created.' }
        format.json { render :show, status: :created, location: @immunization }
      else
        format.html { render :new }
        format.json { render json: @immunization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /immunizations/1
  # PATCH/PUT /immunizations/1.json
  def update
    respond_to do |format|
      if @immunization.update(immunization_params)
        format.html { redirect_to @immunization, notice: 'Immunization was successfully updated.' }
        format.json { render :show, status: :ok, location: @immunization }
      else
        format.html { render :edit }
        format.json { render json: @immunization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /immunizations/1
  # DELETE /immunizations/1.json
  def destroy
    @immunization.destroy
    respond_to do |format|
      format.html { redirect_to immunizations_url, notice: 'Immunization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_immunization
    @immunization = Immunization.find(params[:id])
    add_breadcrumb @immunization, @immunization
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def immunization_params
    params.require(:immunization).permit(Immunization.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @immunization.can?(:edit_immunizations, :manage_immunizations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @immunization.can?(:delete_immunizations, :manage_immunizations, :manage_roles)
  end

end
