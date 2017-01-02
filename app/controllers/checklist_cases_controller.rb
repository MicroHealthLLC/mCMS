class ChecklistCasesController < ApplicationController
  before_action  :authenticate_user!
  before_action :set_checklist_case

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
      format.html { redirect_to checklist_templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def checklist_case_params
    params.require(:checklist_template).permit(:checklist_status_type_id)
  end

  def set_checklist_case
    @checklist_case = ChecklistCase.find(params[:id])
    @checklist = @checklist_case.checklist_template
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
