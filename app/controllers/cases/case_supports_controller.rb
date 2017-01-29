class CaseSupportsController < UserCasesController
  add_breadcrumb I18n.t(:cases_supports), :case_supports_path
  before_action :set_case_support, only: [:remove, :show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:remove, :edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /case_supports
  # GET /case_supports.json
  def index
    respond_to do |format|
      format.html{ @case_supports = CaseSupport.visible}
    end
  end

  # GET /case_supports/1
  # GET /case_supports/1.json
  def show
    respond_to do |format|
      format.html{}
      format.js{
        @case_support = @case_support.dup
        @case_support.user_id = User.current.id
        @case_support.case_id = params[:case_id]
        @case_support.not_show_in_search = true
      }
    end
  end

  # GET /case_supports/new
  def new
    @case_support = CaseSupport.new(user_id: User.current.id, case_id: params[:case_id])
  end

  # GET /case_supports/1/edit
  def edit
  end

  # POST /case_supports
  # POST /case_supports.json
  def create
    @case_support = CaseSupport.new(case_support_params)

    respond_to do |format|
      if @case_support.save
        format.html { redirect_to @case_support, notice: 'Case support was successfully created.' }
        format.json { render :show, status: :created, location: @case_support }
      else
        format.html { render :new }
        format.json { render json: @case_support.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    @case_support.status = params[:back] ? true : false
    @case_support.save
    redirect_to case_support_path(@case_support)
  end


  # PATCH/PUT /case_supports/1
  # PATCH/PUT /case_supports/1.json
  def update
    respond_to do |format|
      if @case_support.update(case_support_params)
        format.html { redirect_to @case_support, notice: 'Case support was successfully updated.' }
        format.json { render :show, status: :ok, location: @case_support }
      else
        format.html { render :edit }
        format.json { render json: @case_support.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_supports/1
  # DELETE /case_supports/1.json
  def destroy
    @case_support.destroy
    respond_to do |format|
      format.html { redirect_to case_supports_url, notice: 'Case support was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    respond_to do |format|
      format.html {}
      format.json{
        q = params[:q].to_s.downcase
        contacts = CaseSupport.not_show_in_search.where('LOWER(first_name) LIKE ? ', "%#{q}%").
            or(CaseSupport.not_show_in_search.where('LOWER(last_name) LIKE ? ', "%#{q}%")).
            or(CaseSupport.not_show_in_search.where('LOWER(middle_name) LIKE ? ', "%#{q}%")).map{|contact| {id: contact.id, value: contact.name, label: contact.name}}.to_json
        render json: contacts
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_case_support
    @case_support = CaseSupport.find(params[:id])
    add_breadcrumb @case_support, @case_support
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def case_support_params
    params.require(:case_support).permit(CaseSupport.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @case_support.can?(:edit_cases, :manage_cases, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @case_support.can?(:delete_cases, :manage_cases, :manage_roles)
  end

end
