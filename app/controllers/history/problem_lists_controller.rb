class ProblemListsController < UserHistoryController
  add_breadcrumb I18n.t(:problem_lists), :problem_lists_path
  before_action :set_problem_list, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /problem_lists
  # GET /problem_lists.json
  def index
    redirect_to medical_record_path if request.format.to_sym == :html
    scope = ProblemList.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @problem_lists = scope
  end

  # GET /problem_lists/1
  # GET /problem_lists/1.json
  def show
  end

  # GET /problem_lists/new
  def new
    @problem_list = ProblemList.new(user_id: User.current.id)
  end

  # GET /problem_lists/1/edit
  def edit
  end

  # POST /problem_lists
  # POST /problem_lists.json
  def create
    @problem_list = ProblemList.new(problem_list_params)

    respond_to do |format|
      if @problem_list.save
        format.html { redirect_to @problem_list, notice: 'ProblemList was successfully created.' }
        format.json { render :show, status: :created, location: @problem_list }
      else
        format.html { render :new }
        format.json { render json: @problem_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problem_lists/1
  # PATCH/PUT /problem_lists/1.json
  def update
    respond_to do |format|
      if @problem_list.update(problem_list_params)
        format.html { redirect_to @problem_list, notice: 'ProblemList was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem_list }
      else
        format.html { render :edit }
        format.json { render json: @problem_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_lists/1
  # DELETE /problem_lists/1.json
  def destroy
    @problem_list.destroy
    respond_to do |format|
      format.html { redirect_to problem_lists_url, notice: 'ProblemList was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_problem_list
    @problem_list = ProblemList.find(params[:id])
    add_breadcrumb @problem_list, @problem_list
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def problem_list_params
    params.require(:problem_list).permit(ProblemList.safe_attributes)
  end

  def authorize_edit
    raise Unauthorized unless @problem_list.can?(:edit_problem_lists, :manage_problem_lists, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @problem_list.can?(:delete_problem_lists, :manage_problem_lists, :manage_roles)
  end

end
