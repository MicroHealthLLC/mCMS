class RelatedClientsController < UserProfilesController


  before_action :set_breadcrumb
  before_action :set_related_client, only: [:show, :edit, :update, :destroy]
  # before_action :find_optional_user


  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  def index
    respond_to do |format|
      format.html{  redirect_to  profile_record_path }
      format.js{}
      format.pdf{}
      format.csv{ params[:length] = 500
      options = Hash.new
      options[:status_type] = params[:status_type]
      json = RelatedClientDatatable.new(view_context, options).as_json
      send_data RelatedClient.to_csv(json[:data]), filename: "RelatedClient-#{Date.today}.csv"
      }
      format.json{
        options = Hash.new
        options[:status_type] = params[:status_type]
        render json: RelatedClientDatatable.new(view_context,options)
      }
    end
  end
  # GET /related_clients/1
  # GET /related_clients/1.json
  def show
  end

  # GET /related_clients/new
  def new
    @related_client = RelatedClient.new(user_id: User.current.id)
  end

  # GET /related_clients/1/edit
  def edit
  end

  # POST /related_clients
  # POST /related_clients.json
  def create
    @related_client = RelatedClient.new(related_client_params)

    respond_to do |format|
      if @related_client.save
        format.html { redirect_to @related_client, notice: 'Related client was successfully created.' }
        format.json { render :show, status: :created, location: @related_client }
      else
        format.html { render :new }
        format.json { render json: @related_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /related_clients/1
  # PATCH/PUT /related_clients/1.json
  def update
    respond_to do |format|
      if @related_client.update(related_client_params)
        format.html { redirect_to @related_client, notice: 'Related client was successfully updated.' }
        format.json { render :show, status: :ok, location: @related_client }
      else
        format.html { render :edit }
        format.json { render json: @related_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /related_clients/1
  # DELETE /related_clients/1.json
  def destroy
    @related_client.destroy
    respond_to do |format|
      format.html { redirect_to related_clients_url, notice: 'Related client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_related_client
    @related_client = RelatedClient.find(params[:id])
    add_breadcrumb @related_client, @related_client
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def related_client_params
    params.require(:related_client).permit(RelatedClient.safe_attributes)
  end

  def  set_breadcrumb
    add_breadcrumb "#{User.current.name}", '/users/edit'
  end


  def authorize_edit
    raise Unauthorized unless @related_client.can?(:edit_related_clients, :manage_related_clients, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @related_client.can?(:delete_related_clients, :manage_related_clients, :manage_roles)
  end
end
