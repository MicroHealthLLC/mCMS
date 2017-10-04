class DocumentFolder < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  belongs_to :parent, class_name: 'DocumentFolder'

  has_many :files, foreign_key: :folder_id, class_name: 'DocumentManager'
end
