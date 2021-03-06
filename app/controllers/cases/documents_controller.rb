class DocumentsController < UserCasesController

  before_action :set_document, only: [:show, :edit, :update, :destroy]

  before_action :authorize_edit, only: [:edit, :update]
  before_action :authorize_delete, only: [:destroy]

  # GET /documents
  # GET /documents.json
  def index
    add_breadcrumb I18n.t(:documents), :documents_path

    options = Hash.new
    options[:status_type] = params[:status_type]
    options[:case_id] = params[:case_id]
    options[:appointment_id] = params[:appointment_id]

    respond_to do |format|
      format.html{ }
      format.js{ render 'application/index' }
      format.pdf{}
      format.csv{
        params[:length] = 500
        options[:show_case] = 'true'
        json = DocumentDatatable.new(view_context, options).as_json
        send_data Document.to_csv(json[:data]), filename: "Document-#{Date.today}.csv"
      }
      format.json{
        render json: DocumentDatatable.new(view_context,options)
      }
    end
  end

  def all_files
    @breadcrumbs =  []
    # add_breadcrumb 'All Files', '/all_files'
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
                             date: Date.today,
                             related_to_id: params[:related_to],
                             related_to_type: params[:type])
    set_breadcrumbs
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
    @case =  @document.case
    respond_to do |format|
      if @document.save
        set_link_to_appointment(@document)
        format.html { redirect_to back_index_case_url, notice: 'Document was successfully created.' }
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
        format.html { redirect_to back_index_case_url, notice: 'Document was successfully updated.' }
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
      format.html { redirect_to back_index_case_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Document.find(params[:id])
    @case =  @document.case
    set_breadcrumbs
    add_breadcrumb @document, document_path(@document)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def set_breadcrumbs
    if @document.case
      add_breadcrumb @document.case,  @document.case
      add_breadcrumb I18n.t(:documents), case_path(@document.case) + "#tabs-documents"
    else
      add_breadcrumb I18n.t(:documents), :documents_path
    end
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

end
