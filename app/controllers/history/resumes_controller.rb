class ResumesController < UserHistoryController
  add_breadcrumb 'Occupational History', '/occupational_record'
  add_breadcrumb I18n.t(:resumes), :resumes_path
  before_action :set_resume, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /resumes
  # GET /resumes.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path + "#tabs-resume" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{
        params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = ResumeDatatable.new(view_context, options).as_json
        send_data Resume.to_csv(json[:data]), filename: "Resume-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: ResumeDatatable.new(view_context,options)
      }
    end
  end

  # GET /resumes/1
  # GET /resumes/1.json
  def show
  end

  # GET /resumes/new
  def new
    @resume = Resume.new(user_id: User.current.id)
  end

  # GET /resumes/1/edit
  def edit
  end

  # POST /resumes
  # POST /resumes.json
  def create
    @resume = Resume.new(resume_params)

    respond_to do |format|
      if @resume.save
        format.html { redirect_to resumes_url, notice: 'Resume was successfully created.' }
      #  format.json { render :show, status: :created, location: @resume }
      else
        format.html { render :new }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resumes/1
  # PATCH/PUT /resumes/1.json
  def update
    respond_to do |format|
      if @resume.update(resume_params)
        format.html { redirect_to resumes_url, notice: 'Resume was successfully updated.' }
      #  format.json { render :show, status: :ok, location: @resume }
      else
        format.html { render :edit }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resumes/1
  # DELETE /resumes/1.json
  def destroy
    @resume.destroy
    respond_to do |format|
      format.html { redirect_to resumes_url, notice: 'Resume was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_resume
    @resume = Resume.find(params[:id])
    add_breadcrumb @resume, @resume
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def resume_params
    params.require(:resume).permit(Resume.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @resume.can?(:edit_resumes, :manage_resumes, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @resume.can?(:delete_resumes, :manage_resumes, :manage_roles)
  end

end
