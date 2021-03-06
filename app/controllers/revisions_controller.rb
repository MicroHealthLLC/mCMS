class RevisionsController < ProtectForgeryApplication
  before_action  :authenticate_user!
  before_action  :authorize

  def download
    # Get the request document revision
    @revision = Revision.find(params[:revision_id])

    if !@revision.nil?
      # Increment the download count on this revision
      @revision.increment!(:download_count)
      # Send file binary data to the user's browser
      send_data(@revision.file_data, 
        type: @revision.file_type, 
        filename: @revision.file_name,
        disposition: "inline")
    else
      flash[:error] = "Could not find the requested document"
      redirect_to document_managers_path
    end
  end

  def create
    @document = DocumentManager.find(params[:document_manager_id])

    @revision = Revision.new(file_name: revision_params.original_filename,
        file_type: revision_params.content_type,
        file_data: revision_params.read,
        document_manager_id: @document.id,
        user_id: current_user.id,
        position: 0
      )
    d = DmsDocumemnt.new(document_manager_id: @document.id)
    d.doc = params[:revision][:file]
    d.save
    # Set this new revision as the current revision
    @revision.position = 0
    # Increase the position of all previous revisions
    #  to move them down in the document's history
    @document.revisions.each do |revision|
      revision.position += 1
      revision.save
    end

    if !@revision.save
      flash[:error] = "Unable to upload revision"
      redirect_to document_manager_path(@document)
    else
      # Our revision has been saved
      #  extract it's contents for the search engine
      @revision.extract_text
      redirect_to document_manager_path(@document)
    end
  end

  private 
    def revision_params
      params[:revision][:file]
    end

end
