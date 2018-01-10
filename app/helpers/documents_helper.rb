module DocumentsHelper
  def back_url doc
    doc.related_to_id ? case_url(doc.case)+'#tabs-documents' : client_documents_path
  end
end
