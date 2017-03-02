class ClientJournalsController < UserCasesController
  add_breadcrumb I18n.t(:client_journals), :client_journals_path
  before_action :set_client_journal, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]


  # GET /client_journals
  # GET /client_journals.json
  def index
    scope = ClientJournal.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.opened
            end


    @client_journals = scope
  end

  # GET /client_journals/1
  # GET /client_journals/1.json
  def show
  end

  # GET /client_journals/new
  def new
    @client_journal = ClientJournal.new(user_id: User.current.id)
  end

  # GET /client_journals/1/edit
  def edit
  end

  # POST /client_journals
  # POST /client_journals.json
  def create
    @client_journal = ClientJournal.new(client_journal_params)

    respond_to do |format|
      if @client_journal.save
        format.html { redirect_to @client_journal, notice: 'Client journal was successfully created.' }
        format.json { render :show, status: :created, location: @client_journal }
      else
        format.html { render :new }
        format.json { render json: @client_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_journals/1
  # PATCH/PUT /client_journals/1.json
  def update
    respond_to do |format|
      if @client_journal.update(client_journal_params)
        format.html { redirect_to @client_journal, notice: 'Client journal was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_journal }
      else
        format.html { render :edit }
        format.json { render json: @client_journal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_journals/1
  # DELETE /client_journals/1.json
  def destroy
    @client_journal.destroy
    respond_to do |format|
      format.html { redirect_to client_journals_url, notice: 'Client journal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client_journal
    @client_journal = ClientJournal.find(params[:id])
    add_breadcrumb @client_journal, @client_journal
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_journal_params
    params.require(:client_journal).permit(ClientJournal.safe_attributes)
  end
  
  def authorize_edit
    raise Unauthorized unless @client_journal.can?(:edit_client_journals, :manage_client_journals, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @client_journal.can?(:delete_client_journals, :manage_client_journals, :manage_roles)
  end
end
