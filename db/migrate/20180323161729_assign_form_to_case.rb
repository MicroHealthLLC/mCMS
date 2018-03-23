class AssignFormToCase < ActiveRecord::Migration[5.0]
  def change
    Formular.where(placement: Formular::CASE_RECORD).each do |form|
      form.form_details.each do |detail|
        if detail.case_id.nil?
          detail.case_id = detail.user.cases.first.id rescue nil
          detail.save
        end

      end
    end
  end
end
