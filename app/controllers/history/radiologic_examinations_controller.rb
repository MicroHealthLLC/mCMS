class RadiologicExaminationsController < UserHistoryController

  add_breadcrumb I18n.t(:radiologic_examination), :radiologic_examinations_path
  before_action :set_radiologic_examination, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /radiologic_examinations
  # GET /radiologic_examinations.json
  def index
    respond_to do |format|
      format.html{  redirect_to  medical_record_path }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = RadiologicExaminationDatatable.new(view_context, options).as_json
        send_data RadiologicExamination.to_csv(json[:data]), filename: "radiologic-exam-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: RadiologicExaminationDatatable.new(view_context,options)
      }
    end
  end

  # GET /radiologic_examinations/1
  # GET /radiologic_examinations/1.json
  def show
  end

  # GET /radiologic_examinations/new
  def new
    @radiologic_examination = RadiologicExamination.new(user_id: User.current.id)
  end

  # GET /radiologic_examinations/1/edit
  def edit
  end

  # POST /radiologic_examinations
  # POST /radiologic_examinations.json
  def create
    @radiologic_examination = RadiologicExamination.new(radiologic_examination_params)

    respond_to do |format|
      if @radiologic_examination.save
        format.html { redirect_to @radiologic_examination, notice: 'Radiologic examination was successfully created.' }
        format.json { render :show, status: :created, location: @radiologic_examination }
      else
        format.html { render :new }
        format.json { render json: @radiologic_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /radiologic_examinations/1
  # PATCH/PUT /radiologic_examinations/1.json
  def update
    respond_to do |format|
      if @radiologic_examination.update(radiologic_examination_params)
        format.html { redirect_to @radiologic_examination, notice: 'Radiologic examination was successfully updated.' }
        format.json { render :show, status: :ok, location: @radiologic_examination }
      else
        format.html { render :edit }
        format.json { render json: @radiologic_examination.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /radiologic_examinations/1
  # DELETE /radiologic_examinations/1.json
  def destroy
    @radiologic_examination.destroy
    respond_to do |format|
      format.html { redirect_to radiologic_examinations_url, notice: 'Radiologic examination was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_radiologic_examination
    @radiologic_examination = RadiologicExamination.find(params[:id])
    add_breadcrumb @radiologic_examination, @radiologic_examination
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def radiologic_examination_params
    params.require(:radiologic_examination).permit(RadiologicExamination.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @radiologic_examination.can?(:edit_radiologic_examinations, :manage_radiologic_examinations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @radiologic_examination.can?(:delete_radiologic_examinations, :manage_radiologic_examinations, :manage_roles)
  end

end
