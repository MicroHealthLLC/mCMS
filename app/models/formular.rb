class Formular < ApplicationRecord
  validates_presence_of :name, :form
  validates_uniqueness_of :name

  has_many :form_details, dependent: :destroy
  # has_many :form_results, through: :form_details, dependent: :destroy

  EMPLACEMENT = [['Profile Record', 1],
                 ['Occupation Record', 2],
                 ['Health Record', 3],
                 ['Socioeconomic Record', 4]]

  def self.for(emplacement)
    where(placement: emplacement)
  end

  def self.safe_attributes
    [:name, :icon, :placement, :form]
  end

  def emplacement
    case placement
      when 1 then 'Profile Record'
      when 2 then 'Occupation Record'
      when 3 then 'Health Record'
      when 4 then 'Socioeconomic Record'
      else ''

    end
  end
end
