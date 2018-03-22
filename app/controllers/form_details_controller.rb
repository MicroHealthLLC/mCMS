class FormDetailsController < ApplicationController
  before_action  :authenticate_user!
  before_action :set_formular
  before_action :set_form_result, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /form_results/1
  # GET /form_results/1.json
  def show
  end

  # GET /form_results/new
  def new
    @form_detail = @formular.form_details.new(user_id: User.current.id)
  end

  # GET /form_results/1/edit
  def edit
  end

  # POST /form_results
  # POST /form_results.json
  def create
    @form_detail = @formular.form_details.new(user_id: User.current.id)
    respond_to do |format|
      if @form_detail.save
        form = JSON.parse @formular.form
        form.each do |f|
          value = params[f['name']]
          FormResult.create(
              user_id: User.current.id,
              formular_id: @formular.id,
              form_detail_id: @form_detail.id,
              name: f['name'],
              value: value
          )
        end

        format.html { redirect_to back_url , notice: 'Form result was successfully created.' }
        format.json { render :show, status: :created, location: @form_detail }
      else
        format.html { render :new }
        format.json { render json: @form_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /form_results/1
  # PATCH/PUT /form_results/1.json
  def update
    respond_to do |format|
      if @form_detail.update(form_result_params)
        form = JSON.parse @formular.form
        form.each do |f|
          value = params[f['name']]
          form_result = FormResult.where(
              user_id: User.current.id,
              formular_id: @formular.id,
              form_detail_id: @form_detail.id,
              name: f['name']
          ).first_or_initialize
          form_result.value = value
          form_result.save
        end

        format.html { redirect_to back_url, notice: 'Form result was successfully updated.' }
        format.json { render :show, status: :ok, location: @form_detail }
      else
        format.html { render :edit }
        format.json { render json: @form_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_results/1
  # DELETE /form_results/1.json
  def destroy
    @form_detail.destroy
    respond_to do |format|
      format.html { redirect_to formular_url(@formular), notice: 'Form result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_formular
    @formular = Formular.find(params[:formular_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_form_result
    @form_detail = @formular.form_details.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_result_params
    params.require(:form_detail).permit(:user_id, :formular_id)
  end

  def back_url
    case @formular.placement.to_i
      when 1 then '/profile_record#tabs-forms'
      when 2 then '/occupation_record#tabs-forms'
      when 3 then '/medical_record#tabs-forms'
      when 4 then '/socioeconomic_record#tabs-forms'
      when 5 then '/cases'
        else root_path
    end
  end

  def authorize_edit
    raise Unauthorized unless @form_detail.can?(:edit_form_details, :manage_form_details, :manage_roles) and User.current == @form_detail.user
  end

  def authorize_delete
    raise Unauthorized unless @form_detail.can?(:delete_form_details, :manage_form_details, :manage_roles) and User.current == @form_detail.user
  end
end
