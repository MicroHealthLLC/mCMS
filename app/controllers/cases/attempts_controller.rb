class AttemptsController < UserCasesController

  helper 'surveys'

  before_filter :load_active_survey, only: [:new, :create, :index]
  before_filter :normalize_attempts_data, :only => :create

  def index
    scope = @survey.attempts.includes(:answers=>[:option,:question=> [:survey, :options=>[:question]]])
    if params[:case_id]
      @case = Case.find( params[:case_id])
      @attempts = scope.where(participant_type: 'Case', participant_id: params[:case_id])
    else
      @attempts = scope.where(participant: User.current)
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def new
    if params[:case_id]
      @case = Case.find(params[:case_id])
      @participant = @case # you have to decide what to do here
    else
      @participant = User.current # you have to decide what to do here
    end


    unless @survey.nil?
      @attempt = @survey.attempts.new
      @attempt.answers.build
    end
    redirect_to surveys_path unless @attempt.can_do_one_more_attempt?(@participant)
  end

  def show
    @attempt = Survey::Attempt.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def create
    @attempt = @survey.attempts.new(attempt_params)
    if params[:case_id].present?
      @attempt.participant =  Case.find(params[:case_id])
    else
      @attempt.participant =  User.current
    end

    @participant = @attempt.participant

    if @attempt.valid? && @attempt.save
      if params[:case_id]
        redirect_to view_context.new_attempt(survey_id: @survey.id, case_id: params[:case_id]), alert: I18n.t("attempts_controller.#{action_name}")

      else
        redirect_to view_context.new_attempt(survey_id: @survey.id), alert: I18n.t("attempts_controller.#{action_name}")

      end
       else
      render :action => :new
    end
  end

  private

  def load_active_survey
    @survey =  Survey::Survey.includes(:questions=> [:options]).find(params[:survey_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def normalize_attempts_data
    normalize_data!(params[:survey_attempt][:answers_attributes])
  end

  def normalize_data!(hash)
    multiple_answers = []
    last_key = hash.keys.last.to_i

    hash.keys.each do |k|
      if hash[k]['option_id'].is_a?(Array)
        if hash[k]['option_id'].size == 1
          hash[k]['option_id'] = hash[k]['option_id'][0]
          next
        else
          multiple_answers <<  k if hash[k]['option_id'].size > 1
        end
      end
    end

    multiple_answers.each do |k|
      hash[k]['option_id'][1..-1].each do |o|
        last_key += 1
        hash[last_key.to_s] = hash[k].merge('option_id' => o)
      end
      hash[k]['option_id'] = hash[k]['option_id'].first
    end
  end

  def attempt_params
    rails4? or rails5? ? params_whitelist : params[:survey_attempt]
  end

  def params_whitelist
    params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
  end
end
