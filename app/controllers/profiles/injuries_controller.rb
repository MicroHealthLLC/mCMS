class InjuriesController < UserProfilesController
  add_breadcrumb I18n.t(:injuries), :injuries_path
  before_action :set_injury, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


# GET /injuries
# GET /injuries.json
  def index
    respond_to do |format|
      format.html{  redirect_to occupational_record_path + "#tabs-injuries" }
     format.js{ render 'application/index' }
      format.pdf{}
      format.csv{ params[:length] = 500
        options = Hash.new
        options[:status_type] = params[:status_type]
        json = InjuryDatatable.new(view_context, options).as_json
        send_data Injury.to_csv(json[:data]), filename: "Injury-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: InjuryDatatable.new(view_context,options)
      }
    end
  end

# GET /injuries/1
# GET /injuries/1.json
  def show
  end

# GET /injuries/new
  def new
    @injury = Injury.new(user_id: User.current.id)
  end

# GET /injuries/1/edit
  def edit
  end

# POST /injuries
# POST /injuries.json
  def create
    @injury = Injury.new(injury_params)

    respond_to do |format|
      if @injury.save
        format.html { redirect_to injuries_url, notice: 'Injury was successfully created.' }
        format.json { render :show, status: :created, location: @injury }
      else
        format.html { render :new }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /injuries/1
# PATCH/PUT /injuries/1.json
  def update
    respond_to do |format|
      if @injury.update(injury_params)
        format.html { redirect_to injuries_url, notice: 'Injury was successfully updated.' }
        format.json { render :show, status: :ok, location: @injury }
      else
        format.html { render :edit }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /injuries/1
# DELETE /injuries/1.json
  def destroy
    @injury.destroy
    respond_to do |format|
      format.html { redirect_to injuries_url, notice: 'Injury was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_injury
    @injury = Injury.find(params[:id])
    add_breadcrumb @injury, @injury
  rescue ActiveRecord::RecordNotFound
    render_404
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def injury_params
    params.require(:injury).permit(Injury.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @injury.can?(:view_injuries, :manage_injuries, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @injury.can?(:edit_injuries, :manage_injuries, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @injury.can?(:delete_injuries, :manage_injuries, :manage_roles)
  end
end
