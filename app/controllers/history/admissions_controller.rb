class AdmissionsController < UserHistoryController
  add_breadcrumb 'Health History', '/medical_record'
  add_breadcrumb I18n.t(:admissions), :admissions_path
  before_action :set_admission, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /admissions
  # GET /admissions.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path + "#tabs-admission" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = AdmissionDatatable.new(view_context, options).as_json
        send_data Admission.to_csv(json[:data]), filename: "Admission-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: AdmissionDatatable.new(view_context,options)
      }
    end
  end

  # GET /admissions/1
  # GET /admissions/1.json
  def show
  end

  # GET /admissions/new
  def new
    @admission = Admission.new(user_id: User.current.id)
  end

  # GET /admissions/1/edit
  def edit
  end

  # POST /admissions
  # POST /admissions.json
  def create
    @admission = Admission.new(admission_params)

    respond_to do |format|
      if @admission.save
        format.html { redirect_to admissions_url, notice: 'Admission was successfully created.' }
      #  format.json { render :show, status: :created, location: @admission }
      else
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admissions/1
  # PATCH/PUT /admissions/1.json
  def update
    respond_to do |format|
      if @admission.update(admission_params)
        format.html { redirect_to admissions_url, notice: 'Admission was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @admission }
      else
        format.html { render :edit }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admissions/1
  # DELETE /admissions/1.json
  def destroy
    @admission.destroy
    respond_to do |format|
      format.html { redirect_to admissions_url, notice: 'Admission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admission
    @admission = Admission.find(params[:id])
    add_breadcrumb @admission, @admission
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admission_params
    params.require(:admission).permit(Admission.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @admission.can?(:edit_admissions, :manage_admissions, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @admission.can?(:delete_admissions, :manage_admissions, :manage_roles)
  end

end
