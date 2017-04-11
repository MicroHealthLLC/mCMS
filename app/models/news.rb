class News < ApplicationRecord
  audited except: [:created_by_id, :updated_by_id]
  belongs_to :user
  has_many :post_notes, foreign_key: :owner_id, dependent: :destroy

  has_many :post_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :post_attachments, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :user_id, :title, :summary, :description

  def visible?
    true
  end

  def to_s
   title
  end

  def self.safe_attributes
    [
        :user_id, :title, :summary, :description,
        post_attachments_attributes: [Attachment.safe_attributes]
    ]
  end

  def can_send_email?
    false
  end

  def for_mail
    output = ""
    output<< "<h2>New post ##{id} </h2>"
    output<<"<b>Created on: </b> #{created_at}<br/>"
    output<<"<b>#{title}: </b><br/>"
    output<<"<b></b>#{summary}<br/>"
    output<<"<b></b>#{description}<br/>"

    output.html_safe
  end

end
