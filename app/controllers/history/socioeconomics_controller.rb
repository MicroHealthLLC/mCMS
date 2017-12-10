class SocioeconomicsController < UserHistoryController
  add_breadcrumb I18n.t(:socioeconomics), :socioeconomics_path
  before_action :set_socioeconomic, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /socioeconomics
  # GET /socioeconomics.json
  def index
    respond_to do |format|
      format.html{  redirect_to  socioeconomic_record_path + "#tabs-socioeconomic" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = SocioeconomicDatatable.new(view_context, options).as_json
        send_data Socioeconomic.to_csv(json[:data]), filename: "socioeconimic-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: SocioeconomicDatatable.new(view_context,options)
      }
    end
  end

  # GET /socioeconomics/1
  # GET /socioeconomics/1.json
  def show
  end

  # GET /socioeconomics/new
  def new
    @socioeconomic = Socioeconomic.new(date_identified: Date.today,
                                       user_id: User.current.id)
  end

  # GET /socioeconomics/1/edit
  def edit
  end

  # POST /socioeconomics
  # POST /socioeconomics.json
  def create
    @socioeconomic = Socioeconomic.new(socioeconomic_params)

    respond_to do |format|
      if @socioeconomic.save
        format.html { redirect_to @socioeconomic, notice: 'Socioeconomic was successfully created.' }
        format.json { render :show, status: :created, location: @socioeconomic }
      else
        format.html { render :new }
        format.json { render json: @socioeconomic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /socioeconomics/1
  # PATCH/PUT /socioeconomics/1.json
  def update
    respond_to do |format|
      if @socioeconomic.update(socioeconomic_params)
        format.html { redirect_to @socioeconomic, notice: 'Socioeconomic was successfully updated.' }
        format.json { render :show, status: :ok, location: @socioeconomic }
      else
        format.html { render :edit }
        format.json { render json: @socioeconomic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /socioeconomics/1
  # DELETE /socioeconomics/1.json
  def destroy
    @socioeconomic.destroy
    respond_to do |format|
      format.html { redirect_to socioeconomics_url, notice: 'Socioeconomic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_socioeconomic
    @socioeconomic = Socioeconomic.find(params[:id])
    add_breadcrumb @socioeconomic, @socioeconomic
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def socioeconomic_params
    params.require(:socioeconomic).permit(Socioeconomic.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @socioeconomic.can?(:edit_socioeconomics, :manage_socioeconomics, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @socioeconomic.can?(:delete_socioeconomics, :manage_socioeconomics, :manage_roles)
  end

end
