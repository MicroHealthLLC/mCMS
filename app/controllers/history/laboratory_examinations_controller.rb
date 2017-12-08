class LaboratoryExaminationsController < UserHistoryController

  add_breadcrumb I18n.t(:laboratory_examinations), :laboratory_examinations_path
  before_action :set_laboratory_examination, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /laboratory_examinations
  # GET /laboratory_examinations.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = LaboratoryExaminationDatatable.new(view_context, options).as_json
        send_data LaboratoryExamination.to_csv(json[:data]), filename: "Legal-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: LaboratoryExaminationDatatable.new(view_context,options)
      }
    end
  end

  # GET /laboratory_examinations/1
  # GET /laboratory_examinations/1.json
  def show
  end

  # GET /laboratory_examinations/new
  def new
    @laboratory_examination = LaboratoryExamination.new(user_id: User.current.id)
  end

  # GET /laboratory_examinations/1/edit
  def edit
  end

  # POST /laboratory_examinations
  # POST /laboratory_examinations.json
  def create
    @laboratory_examination = LaboratoryExamination.new(laboratory_examination_params)

    respond_to do |format|
      if @laboratory_examination.save
        format.html { redirect_to @laboratory_examination, notice: 'Radiologic examination was successfully created.' }
        format.json { render :show, status: :created, location: @laboratory_examination }
      else
        format.html { render :new }
        format.json { render json: @laboratory_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laboratory_examinations/1
  # PATCH/PUT /laboratory_examinations/1.json
  def update
    respond_to do |format|
      if @laboratory_examination.update(laboratory_examination_params)
        format.html { redirect_to @laboratory_examination, notice: 'Radiologic examination was successfully updated.' }
        format.json { render :show, status: :ok, location: @laboratory_examination }
      else
        format.html { render :edit }
        format.json { render json: @laboratory_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /laboratory_examinations/1
  # DELETE /laboratory_examinations/1.json
  def destroy
    @laboratory_examination.destroy
    respond_to do |format|
      format.html { redirect_to laboratory_examinations_url, notice: 'Radiologic examination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_laboratory_examination
    @laboratory_examination = LaboratoryExamination.find(params[:id])
    add_breadcrumb @laboratory_examination, @laboratory_examination
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def laboratory_examination_params
    params.require(:laboratory_examination).permit(LaboratoryExamination.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @laboratory_examination.can?(:edit_laboratory_examinations, :manage_laboratory_examinations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @laboratory_examination.can?(:delete_laboratory_examinations, :manage_laboratory_examinations, :manage_roles)
  end

end
