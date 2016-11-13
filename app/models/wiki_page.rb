class WikiPage < ActiveRecord::Base
  has_many :wiki_page_attachments, foreign_key: :owner_id
  accepts_nested_attributes_for :wiki_page_attachments, reject_if: :all_blank, allow_destroy: true


  acts_as_wiki_page
end
