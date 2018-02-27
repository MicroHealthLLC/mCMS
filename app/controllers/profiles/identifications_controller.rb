class IdentificationsController < UserProfilesController
#  add_breadcrumb 'Client Profile', '/profile_record'
#  add_breadcrumb I18n.t(:identifications), :identifications_path
  before_action :set_identification, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /identifications
  # GET /identifications.json
  def index
    respond_to do |format|
      format.html{  redirect_to  profile_record_path + "#tabs-identification" }
      format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = IdentificationDatatable.new(view_context, options).as_json
        send_data Identification.to_csv(json[:data]), filename: "Identification-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: IdentificationDatatable.new(view_context,options)
      }
    end
  end

  # GET /identifications/1
  # GET /identifications/1.json
  def show
  end

  # GET /identifications/new
  def new
    @identification = Identification.new user_id: User.current.id
  end

  # GET /identifications/1/edit
  def edit
  end

  # POST /identifications
  # POST /identifications.json
  def create
    @identification = Identification.new(identification_params)

    respond_to do |format|
      if @identification.save
        format.html { redirect_to identifications_url, notice: 'Identification was successfully created.' }
      #  format.json { render :show, status: :created, location: @identification }
      else
        format.html { render :new }
        format.json { render json: @identification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /identifications/1
  # PATCH/PUT /identifications/1.json
  def update
    respond_to do |format|
      if @identification.update(identification_params)
        format.html { redirect_to identifications_url, notice: 'Identification was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @identification }
      else
        format.html { render :edit }
        format.json { render json: @identification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /identifications/1
  # DELETE /identifications/1.json
  def destroy
    @identification.destroy
    respond_to do |format|
      format.html { redirect_to identifications_url, notice: 'Identification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_identification
    @identification = Identification.find(params[:id])
    add_breadcrumb @identification, @identification
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def identification_params
    params.require(:identification).permit(Identification.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @identification.can?(:view_identifications, :manage_identifications, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @identification.can?(:edit_identifications, :manage_identifications, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @identification.can?(:delete_identifications, :manage_identifications, :manage_roles)
  end
end
