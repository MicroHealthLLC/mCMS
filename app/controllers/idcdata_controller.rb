class IdcdataController < ApplicationController
  def index
    q = params[:term]
    data = Icd10datum.where('name LIKE ?', "#{q}%").
        select("id AS id, CONCAT('(', name,') ', description ) AS value,  CONCAT('(', name,') ', description )  AS label").to_json

    render json: data
  end
end
