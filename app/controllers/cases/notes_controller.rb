class NotesController < UserCasesController

  before_action :set_note, only: [:update, :edit, :show, :destroy]

  def index
    scope = Note
    scope = scope.where(type: params[:note_type]) if params[:note_type]
    @notes = scope.visible#.paginate(page: params[:page], per_page: 25)
  end

  def get_template_note
    @note_id = params[:note_id]
    @note_template = NoteTemplate.find(params[:note_template_id]) rescue nil
  end

  def new
    @note = Note.new(type: params[:type], owner_id: params[:owner_id], user_id: User.current.id)
  rescue
    render_404
  end

  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note.object, notice: I18n.t(:notice_successful_create) }
      else
        format.html { render :edit }
      end
    end
  end

  def edit

  end

  def show

  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to  @note.object, notice: I18n.t(:notice_successful_update) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    root = @note.object
    @note.destroy
    respond_to do |format|
      format.html { redirect_to root, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def note_params
    type = if params[:checklist_note]
             :checklist_note
           elsif params[:survey_note]
             :survey_note
           elsif params[:case_note]
             :case_note
           elsif params[:task_note]
             :task_note
           elsif params[:post_note]
             :post_note
           elsif params[:need_note]
             :need_note
           elsif params[:goal_note]
             :goal_note
           elsif params[:plan_note]
             :plan_note
           elsif params[:appointment_note]
             :appointment_note
           elsif params[:document_note]
             :document_note
            elsif params[:attempt_note]
             :attempt_note
           else
             :note
           end
    params.require(type).permit(Note.safe_attributes)
  end
end
