class ReferralResultsController < ApplicationController
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!
  before_action :authorize

  before_action :set_referral
  before_action :set_referral_result, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /referral_results
  # GET /referral_results.json
  def index
    @referral_results = ReferralResult.visible
  end

  # GET /referral_results/1
  # GET /referral_results/1.json
  def show
  end

  # GET /referral_results/new
  def new
    @referral_result = ReferralResult.new(user_id: User.current.id, referral_id: @referral.id)
  end

  # GET /referral_results/1/edit
  def edit
  end

  # POST /referral_results
  # POST /referral_results.json
  def create
    @referral_result = ReferralResult.new(referral_result_params)

    respond_to do |format|
      if @referral_result.save
        format.html { redirect_to(referral_url(@referral), notice: 'Referral result was successfully created.') }
        format.json { render :show, status: :created, location: @referral_result }
      else
        format.html { render :new }
        format.json { render json: @referral_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referral_results/1
  # PATCH/PUT /referral_results/1.json
  def update
    respond_to do |format|
      if @referral_result.update(referral_result_params)
        format.html { redirect_to(referral_url(@referral), notice: 'Referral result was successfully updated.' )}
        format.json { render :show, status: :ok, location: @referral_result }
      else
        format.html { render :edit }
        format.json { render json: @referral_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referral_results/1
  # DELETE /referral_results/1.json
  def destroy
    @referral_result.destroy
    respond_to do |format|
      format.html { redirect_to referral_url(@referral), notice: 'Referral result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_referral_result
    @referral_result = ReferralResult.find(params[:id])
    add_breadcrumb @referral.to_s, @referral
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def referral_result_params
    params.require(:referral_result).permit(ReferralResult.safe_attributes)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_referral
    @referral = Referral.find(params[:referral_id])
    add_breadcrumb @referral.to_s, @referral
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def authorize
    super('referrals', params[:action])
  end

  def authorize_edit
    raise Unauthorized unless @referral.can?(:edit_referrals, :manage_referrals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @referral.can?(:delete_referrals, :manage_referrals, :manage_roles)
  end
end
