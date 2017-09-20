class EducationsController < UserProfilesController

  add_breadcrumb I18n.t(:educations), :educations_path
  before_action :set_education, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /educations
  # GET /educations.json
  def index
    redirect_to occupational_record_path if request.format.to_sym == :html
    @educations = Education.for_status params[:status_type]
  end

  # GET /educations/1
  # GET /educations/1.json
  def show
  end

  # GET /educations/new
  def new
    @education = Education.new(user_id: User.current.id)
  end

  # GET /educations/1/edit
  def edit
  end

  # POST /educations
  # POST /educations.json
  def create
    @education = Education.new(education_params)

    respond_to do |format|
      if @education.save
        format.html { redirect_to educations_url, notice: 'Education was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /educations/1
  # PATCH/PUT /educations/1.json
  def update
    respond_to do |format|
      if @education.update(education_params)
        format.html { redirect_to educations_url, notice: 'Education was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /educations/1
  # DELETE /educations/1.json
  def destroy
    @education.destroy
    respond_to do |format|
      format.html { redirect_to educations_url, notice: 'Education was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_education
      @education = Education.find(params[:id])
      add_breadcrumb @education, @education
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def education_params
      params.require(:education).permit(Education.safe_attributes)
    end

  def authorize_edit
    raise Unauthorized unless @education.can?(:edit_educations, :manage_educations, :manage_roles)
  end

  def authorize_show
    raise Unauthorized unless @education.can?(:view_educations, :manage_educations, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @education.can?(:delete_educations, :manage_educations, :manage_roles)
  end
end
