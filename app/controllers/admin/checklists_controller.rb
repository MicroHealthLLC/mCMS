class ChecklistsController < ProtectForgeryApplication
  before_action :authenticate_user!
  before_action :set_checklist_template, only: [:show, :edit, :update, :destroy]

  before_action :require_admin

  def index
    scope = ChecklistTemplate.order('id DESC')
    @checklists = scope.paginate(page: params[:page], per_page: 25)
  end

  def new_assign
    if request.post?
      @checklist = ChecklistUser.new(params.require(:checklist_user).permit(ChecklistUser.safe_attributes))
      if @checklist.save
        redirect_to checklist_templates_path
      else
        @checklists = ChecklistTemplate.order('title ASC') - used_checklist_templates
      end
    else
      @checklists = ChecklistTemplate.order('title ASC') - used_checklist_templates
      @checklist = ChecklistUser.new(assigned_to_id: User.current.id)
    end
  end

  def show
  end

  def new
    @checklist = ChecklistTemplate.new(user_id: User.current.id,
                                       related_to_id: params[:related_to],
                                       related_to_type: params[:type])
    @checklist.checklists.build
  end

  def edit
  end

  def create
    @checklist = ChecklistTemplate.new(checklist_template_params)

    respond_to do |format|
      if @checklist.save
        format.html { redirect_to back_url, notice: 'Template was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @checklist.update(checklist_template_params)
        format.html { redirect_to back_url, notice: 'Template was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @checklist.destroy
      respond_to do |format|
        format.html { redirect_to checklist_templates_url, notice: 'Template was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = @checklist.errors.full_messages.join('<br/>')
      respond_to do |format|
        format.html { redirect_to edit_checklist_template_url(@checklist) }
        format.json { head :no_content }
      end
    end      
  end

  private

  def used_checklist_templates
    ChecklistTemplate.where(id: ChecklistUser.
        where(assigned_to_id: User.current.id).
        pluck(:checklist_template_id))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_checklist_template
    @checklist = ChecklistTemplate.includes(:checklists).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def checklist_template_params
    params.require(:checklist_template).permit(ChecklistTemplate.safe_attributes)
  end

  def back_url
    if @checklist.case
      case_url(@checklist.case)
    else
      checklist_templates_url
    end
  end

end
