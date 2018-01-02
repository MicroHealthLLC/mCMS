class Formular < ApplicationRecord
  validates_presence_of :name, :form
  validates_uniqueness_of :name
end
