class ChecklistCasesController < UserCasesController
  before_action :set_checklist_case, only: [:show, :update, :destroy]

  def index
    add_breadcrumb 'Checklists', :checklist_cases_path
    cases = Case.root
    cases = cases.visible
    scope =  ChecklistCase
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @checklists = scope.includes(:checklist_template).
        references(:checklist_template).include_enumerations.
        where(assigned_to_id:  cases.pluck(:id))
    # Use AJAx DataTable next time
  end

  def show
  end

  def update
    if params[:checklist_answer]
      params[:checklist_answer].each do |key, answer|
        checklist_id = answer[:checklist_id]
        user_id = answer[:user_id]
        res = ChecklistAnswer.where(user_id: user_id)
                  .where(checklist_id: checklist_id )
                  .where(checklist_case_id: @checklist_case.id )
                  .where(checklist_template_id: @checklist.id ).first_or_initialize
        res.update(answer.permit!.reverse_merge({status: false}))
      end
    end
    @checklist_case.update(checklist_case_params)

    redirect_to @checklist_case , notice: 'Checklist was successfully updated.'
  end

  def destroy
    @checklist_case.destroy
    respond_to do |format|
      format.html { redirect_to back_index_case_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def checklist_case_params
    params.require(:checklist_template).permit(:checklist_status_type_id)
  end

  def set_checklist_case
    @checklist_case = ChecklistCase.includes(:checklist_template).find(params[:id])
    @checklist = @checklist_case.checklist_template

    if  @checklist_case.case
      add_breadcrumb @checklist_case.case, @checklist_case.case
      add_breadcrumb 'Checklists', case_path(@checklist_case.case) + '#tabs-checklists'
    else
      add_breadcrumb 'Checklists', :checklist_cases_path
    end
    add_breadcrumb @checklist_case, @checklist_case
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
