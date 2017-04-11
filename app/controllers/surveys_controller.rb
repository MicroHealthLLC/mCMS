class SurveysController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_filter :load_survey, :only => [:show, :edit, :update, :new_note, :destroy]
  before_action :require_admin, only: [:edit, :new, :create, :destroy, :update]
  def index
    scope = Survey::Survey
    if User.current.admin?
      scope = scope.order('id DESC').paginate(page: params[:page], per_page: 25)
    else
      @cases_for_btn = Case.visible
      scope = SurveyCase.visible
    end
    @surveys = scope
  end

  def new_assign
    if request.post?
      @survey = SurveyUser.new(params.require(:survey_user).permit(SurveyUser.safe_attributes))

      if @survey.save
        redirect_to surveys_path
      else
        @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyUser.where(assigned_to_id: User.current.id).pluck(:survey_id))
      end
    else
      @surveys = Survey::Survey.order('name ASC') - Survey::Survey.where(id: SurveyUser.where(assigned_to_id: User.current.id).pluck(:survey_id))
      @survey = SurveyUser.new(assigned_to_id: User.current.id)

    end
  end

  def new
    @survey = Survey::Survey.new(  related_to_id: params[:related_to],
                                   related_to_type: params[:type])
  end

  def new_note
    @note = SurveyNote.new(user_id: User.current.id, owner_id: @survey.id)
  end

  def create
    @survey = Survey::Survey.new(survey_params)
    if @survey.valid? && @survey.save
      default_redirect
    else
      render :action => :new
    end
  end

  def edit
  end

  def show
    @notes = @survey.survey_notes
  end

  def update
    if @survey.update_attributes(survey_params)
      default_redirect
    else
      render :action => :edit
    end
  end

  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def default_redirect
    redirect_to back_url, alert: I18n.t("surveys_controller.#{action_name}")
  end

  def load_survey
    @survey = Survey::Survey.includes(:survey_notes, :questions=> [:options]).find(params[:id])
  end

  def survey_params
    rails4? or rails5? ? params_whitelist : params[:survey_survey]
  end

  def params_whitelist
    params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes)
  end

  def back_url
    surveys_url
  end

end
