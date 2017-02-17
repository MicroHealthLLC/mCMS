class Icd10datum < ApplicationRecord
  validates_presence_of :name, :description
  validates_uniqueness_of :name
  belongs_to :parent, class_name: 'Icd10datum'

  scope :between, -> (from, to) { where('(name >= :from AND name <= :to) OR (name LIKE :range_to)',
                                        from: from, to: to, range_to: "#{to}%") }
  before_create do
    d = Icd10datum.where('childrens LIKE ?', "%#{self.name}%").first
    self.parent_id = d.id if d
  end

  def childs
    Icd10datum.where(name: self.childrens.split('/'))
  end
end
