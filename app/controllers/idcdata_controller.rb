class IdcdataController < ApplicationController
  def index
    q = params[:term]
    scope = Icd10datum
    scope = scope.between('Z00', 'Z99') if params[:from]
    data = scope.where('name LIKE ?', "#{q}%").
        select("id AS id, CONCAT('(', name,') ', description ) AS value,  CONCAT('(', name,') ', description )  AS label").to_json

    render json: data
  end
end
