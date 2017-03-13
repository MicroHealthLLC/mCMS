class DocumentsController < UserCasesController
  add_breadcrumb I18n.t(:documents), :documents_path
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /documents
  # GET /documents.json
  def index
    scope = Document.for_cases.visible
    scope = case params[:status_type]
              when 'all' then scope.all_data
              when 'opened' then scope.opened
              when 'closed' then scope.closed
              when 'flagged' then scope.flagged
              else
                scope.all_data
            end
    @documents = scope
  end

  def all_files
    @files = Attachment.visible
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    redirect_to client_document_path(@document, format: params[:format]) if @document.is_client_document
  end

  # GET /documents/new
  def new
    @document = Document.new(user_id: User.current.id,
                             related_to_id: params[:related_to],
                             related_to_type: params[:type])
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        set_link_to_appointment(@document)
        format.html { redirect_to back_url, notice: 'Document was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to back_url, notice: 'Document was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
    add_breadcrumb @document, document_path(@document)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def document_params
    params.require(:document).permit(Document.safe_attributes)
  end

  def authorize_show
    raise Unauthorized unless @document.can?(:view_documents, :manage_documents, :manage_roles)
  end

  def authorize_edit
    raise Unauthorized unless @document.can?(:edit_documents, :manage_documents, :manage_roles)
  end

  def authorize_delete
    raise Unauthorized unless @document.can?(:delete_documents, :manage_documents, :manage_roles)
  end

  def back_url
    if @document.case
      @document.case
    else
      client_documents_url
    end
  end
end
