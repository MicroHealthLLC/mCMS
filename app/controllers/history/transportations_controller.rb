class TransportationsController < UserHistoryController
  add_breadcrumb I18n.t(:transportations), :transportations_path
  before_action :set_transportation, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /transportations
  # GET /transportations.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = TransportationDatatable.new(view_context, options).as_json
        send_data Transportation.to_csv(json[:data]), filename: "Transportation-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: TransportationDatatable.new(view_context,options)
      }
    end
  end

  # GET /transportations/1
  # GET /transportations/1.json
  def show
  end

  # GET /transportations/new
  def new
    @transportation = Transportation.new(user_id: User.current.id,
                                         date_start: Date.today)
  end

  # GET /transportations/1/edit
  def edit
  end

  # POST /transportations
  # POST /transportations.json
  def create
    @transportation = Transportation.new(transportation_params)

    respond_to do |format|
      if @transportation.save
        format.html { redirect_to @transportation, notice: 'Transportation was successfully created.' }
        format.json { render :show, status: :created, location: @transportation }
      else
        format.html { render :new }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transportations/1
  # PATCH/PUT /transportations/1.json
  def update
    respond_to do |format|
      if @transportation.update(transportation_params)
        format.html { redirect_to @transportation, notice: 'Transportation was successfully updated.' }
        format.json { render :show, status: :ok, location: @transportation }
      else
        format.html { render :edit }
        format.json { render json: @transportation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transportations/1
  # DELETE /transportations/1.json
  def destroy
    @transportation.destroy
    respond_to do |format|
      format.html { redirect_to transportations_url, notice: 'Transportation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transportation
      @transportation = Transportation.find(params[:id])
      add_breadcrumb @transportation, @transportation
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transportation_params
      params.require(:transportation).permit(Transportation.safe_attributes)
    end


  def authorize_edit
    raise Unauthorized unless @transportation.can?(:edit_transportations, :manage_transportations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @transportation.can?(:delete_transportations, :manage_transportations, :manage_roles)
  end
end
