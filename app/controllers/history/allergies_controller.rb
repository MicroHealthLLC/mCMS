class AllergiesController < UserHistoryController
  add_breadcrumb I18n.t(:allergies), :allergies_path
  before_action :set_allergy, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /allergies
  # GET /allergies.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = AllergyDatatable.new(view_context, options).as_json
        send_data Allergy.to_csv(json[:data]), filename: "Allergy-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: AllergyDatatable.new(view_context,options)
      }
    end
  end

  # GET /allergies/1
  # GET /allergies/1.json
  def show
  end

  # GET /allergies/new
  def new
    @allergy = Allergy.new(user_id: User.current.id)
  end

  # GET /allergies/1/edit
  def edit
  end

  # POST /allergies
  # POST /allergies.json
  def create
    @allergy = Allergy.new(allergy_params)

    respond_to do |format|
      if @allergy.save
        format.html { redirect_to @allergy, notice: 'Allergy was successfully created.' }
        format.json { render :show, status: :created, location: @allergy }
      else
        format.html { render :new }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /allergies/1
  # PATCH/PUT /allergies/1.json
  def update
    respond_to do |format|
      if @allergy.update(allergy_params)
        format.html { redirect_to @allergy, notice: 'Allergy was successfully updated.' }
        format.json { render :show, status: :ok, location: @allergy }
      else
        format.html { render :edit }
        format.json { render json: @allergy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allergies/1
  # DELETE /allergies/1.json
  def destroy
    @allergy.destroy
    respond_to do |format|
      format.html { redirect_to allergies_url, notice: 'Allergy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_allergy
    @allergy = Allergy.find(params[:id])
    add_breadcrumb @allergy, @allergy
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def allergy_params
    params.require(:allergy).permit(Allergy.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @allergy.can?(:edit_allergies, :manage_allergies, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @allergy.can?(:delete_allergies, :manage_allergies, :manage_roles)
  end

end