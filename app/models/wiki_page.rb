class WikiPage < ActiveRecord::Base
  audited except: [:created_by_id, :updated_by_id]
  has_many :wiki_page_attachments, foreign_key: :owner_id, dependent: :destroy
  accepts_nested_attributes_for :wiki_page_attachments, reject_if: :all_blank, allow_destroy: true

  belongs_to :parent, foreign_key: :sub_page_id, class_name: 'WikiPage'
  validates_uniqueness_of :title
  validates_presence_of :title, :content

  acts_as_wiki_page

  def self_and_ascendants(ids = [])
    if ids.include? self.id
      return [self]
    end
    if self.parent
     return [self] + [self.parent.self_and_ascendants(ids << self.id)].flatten.compact
    end
    [self]
  end

  def self_and_descendants_ids
    descendants_ids = WikiPage.where(sub_page_id: self.id)
    result =  [self.id] + descendants_ids.pluck(:id)
    found = true
    while found
      des = WikiPage.where(sub_page_id: [result - descendants_ids.pluck(:id)] )
      result += des.pluck(:id)
      descendants_ids = des
      found = des.present?
    end
    result.uniq
  end
end
