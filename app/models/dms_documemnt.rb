class DmsDocumemnt < ApplicationRecord
  belongs_to :document_manager

  mount_uploader :doc, AttachmentUploader

end
