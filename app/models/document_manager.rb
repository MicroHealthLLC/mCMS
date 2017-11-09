class DocumentManager < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :folder, :class_name => 'DocumentFolder'
  has_many :revisions, dependent: :destroy
  has_many :dms_documemnts, dependent: :destroy

  validates_presence_of :category

  # Sunspot Solr search configuration for the document object
  searchable do
    # Give document titles higher weight when determining search results
    text :title, default_boost: 2, stored: true
    text :description, stored: true
    text :revision_search_texts, stored: true do
      revisions.map { |revision| revision.search_text }
    end
  end

  def current_revision
    Revision.where(document_manager_id: id).order("position asc").first
  end

  def total_downloads
    revisions.sum(:download_count)
  end

  def self.latest_docs(folder_id)
    categories = Category.where(id: folder_id)
    scope = Revision.includes(:user, :document_manager=>[:category]).
        references(:user, :document_manager=>[:category]).
        where(document_managers: {is_private: false})


    scope.where(categories: {id: categories.pluck(:id)}).
        where(categories: {is_private: false}).
        or( scope.where(categories: {id: categories.pluck(:id)})).
        order('revisions.updated_at DESC')
  end

end
