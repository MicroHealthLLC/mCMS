class CertificationsController < UserProfilesController
  add_breadcrumb 'Occupational History', '/occupational_record'
  add_breadcrumb I18n.t(:certifications), :certifications_path
  before_action :set_certification, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /certifications
  # GET /certifications.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path + "#tabs-certification" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = CertificationDatatable.new(view_context, options).as_json
        send_data Certification.to_csv(json[:data]), filename: "Certification-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: CertificationDatatable.new(view_context,options)
      }
    end
  end

  # GET /certifications/1
  # GET /certifications/1.json
  def show
  end

  # GET /certifications/new
  def new
    @certification = Certification.new(user_id: User.current.id)
  end

  # GET /certifications/1/edit
  def edit
  end

  # POST /certifications
  # POST /certifications.json
  def create
    @certification = Certification.new(certification_params)

    respond_to do |format|
      if @certification.save
        format.html { redirect_to certifications_url, notice: 'Certification was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /certifications/1
  # PATCH/PUT /certifications/1.json
  def update
    respond_to do |format|
      if @certification.update(certification_params)
        format.html { redirect_to certifications_url, notice: 'Certification was successfully updated.' }

      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /certifications/1
  # DELETE /certifications/1.json
  def destroy
    @certification.destroy
    respond_to do |format|
      format.html { redirect_to certifications_url, notice: 'Certification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_certification
    @certification = Certification.
        includes(:certification_type, :certification_attachments).
        find(params[:id])
    add_breadcrumb @certification, @certification
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def certification_params
    params.require(:certification).permit(Certification.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @certification.can?(:view_certifications, :manage_certifications, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @certification.can?(:edit_certifications, :manage_certifications, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @certification.can?(:delete_certifications, :manage_certifications, :manage_roles)
  end
end
