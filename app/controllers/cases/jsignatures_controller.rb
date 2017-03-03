class JsignaturesController < ApplicationController
  add_breadcrumb I18n.t(:home), :root_path
  before_action  :authenticate_user!

  before_action :set_jsignature, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create, only: [:new, :create]
  before_action :authorize_view, only: [:index, :show]
  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  before_action :set_appointment_links, only: [:show]

  def index
    @jsignatures = Case.visible.map(&:jsignatures).flatten
  end

  # GET /jsignatures/1
  # GET /jsignatures/1.json
  def show
  end

  # GET /jsignatures/new
  def new
    @jsignature = Jsignature.new(user_id: User.current_user.id )

    if params[:appointment_id]
      @owner = Appointment.find(params[:appointment_id])
      @jsignature = Jsignature.new(user_id: User.current_user.id,
                                   appointment_id: @owner.id
      )
    elsif params[:case_id]
      @owner = Case.find(params[:case_id])
      @jsignature = Jsignature.new(user_id: User.current_user.id,
                                   case_id: @owner.id
      )
    else
      render_404
    end

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # GET /jsignatures/1/edit
  def edit
  end

  # POST /jsignatures
  # POST /jsignatures.json
  def create
    @jsignature = Jsignature.new(jsignature_params)

    respond_to do |format|
      if @jsignature.save
        format.html { redirect_to @jsignature, notice: 'Jsignature was successfully created.' }
        format.json { render :show, status: :created, location: @jsignature }
      else
        format.html { render :new }
        format.json { render json: @jsignature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jsignatures/1
  # PATCH/PUT /jsignatures/1.json
  def update
    respond_to do |format|
      if @jsignature.update(jsignature_params)
        format.html { redirect_to @jsignature, notice: 'Jsignature was successfully updated.' }
        format.json { render :show, status: :ok, location: @jsignature }
      else
        format.html { render :edit }
        format.json { render json: @jsignature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jsignatures/1
  # DELETE /jsignatures/1.json
  def destroy
    @jsignature.destroy
    respond_to do |format|
      format.html { redirect_to jsignatures_url, notice: 'Jsignature was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_jsignature
    @jsignature = Jsignature.find(params[:id])
    @owner = @jsignature.appointment || @jsignature.case
    add_breadcrumb @owner.to_s, @owner
    add_breadcrumb @jsignature, @jsignature
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def jsignature_params
    params.require(:jsignature).permit(Jsignature.safe_attributes)
  end

  def authorize_create
    raise Unauthorized unless User.current_user.can?(:edit_jsignatures, :manage_jsignatures, :manage_roles)
  end

  def authorize_view
    raise Unauthorized unless User.current_user.can?(:view_jsignatures, :manage_jsignatures, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless User.current_user.admin?
  end

  def authorize_delete
    raise Unauthorized unless User.current_user.admin?
  end

  def set_appointment_links
    @link_id = params[:id]
    @link_type = params[:controller].classify
    c = @link_type.constantize.find(@link_id).case
    @appointments = Appointment.where(related_to_id: c.id).visible
  rescue Exception => e
    @link_type = nil
  end
end
