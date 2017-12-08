class OtherSkillDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= %w{
      OtherSkill.name
      Enumeration.name
      Enumeration.name
      OtherSkill.date_recieved
      OtherSkill.date_expired
    }
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= %w{
      OtherSkill.name
      Enumeration.name
      Enumeration.name
      OtherSkill.date_recieved
      OtherSkill.date_expired
    }
  end

  private

  def data
    records.map do |other_skill|
      [

          @view.link_to_edit_if_can( other_skill.name, {ctrl: :other_skills, object: other_skill }) ,
          other_skill.skill_status.to_s ,
          other_skill.skill_type.to_s ,
          @view.format_date( other_skill.date_received) ,
          @view.format_date( other_skill.date_expired) ,
      ]

    end
  end

  def get_raw_records
    scope = OtherSkill.include_enumerations
    scope.for_status @options[:status_type]
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
