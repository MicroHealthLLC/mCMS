class IdcdataController < ApplicationController
  def index
    q = params[:term]
    search = q.to_s.split(' ')
    cond_desc = []
    cond_name = []
    search.each do |s|
      cond_desc<< "description LIKE '%#{s}%'"
      cond_name<< "name LIKE '%#{s}%'"
    end
    scope = Icd10datum
    # scope = scope.between('Z00', 'Z99') if params[:from] == 'z00'
    # scope = scope.between('Z55', 'Z65') if params[:from] == 'z55'
    data = scope.where("((#{cond_name.join(' OR ')} )) OR (#{cond_desc.join(' AND ')} )").
        select("id AS id, CONCAT('(', name,') ', description ) AS value,  CONCAT('(', name,') ', description )  AS label").to_json

    render json: data
  end
end
