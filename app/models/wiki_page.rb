class WikiPage < ActiveRecord::Base
  has_many :wiki_page_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :wiki_page_attachments, reject_if: :all_blank, allow_destroy: true

  belongs_to :parent, foreign_key: :sub_page_id, class_name: 'WikiPage'
  validates_uniqueness_of :title
  validates_presence_of :title, :content

  acts_as_wiki_page
end
