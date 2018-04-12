class FormResult < ApplicationRecord
  belongs_to :form_detail
  belongs_to :formular
  after_save do
    form_detail.touch(:updated_at)
  end
end
