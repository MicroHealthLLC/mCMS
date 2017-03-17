class DmsDocumemnt < ApplicationRecord
  belongs_to :document_manager
  belongs_to :revision

  mount_uploader :doc, AttachmentUploader

end
