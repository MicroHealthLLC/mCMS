class FormDetail < ApplicationRecord
  has_many :form_results, dependent: :destroy
  belongs_to :user
  belongs_to :formular
end
