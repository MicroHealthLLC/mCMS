class ImmunizationCvxController < ApplicationController
  def index
    q = params[:term]
    search = q.to_s.split(' ')
    cond_desc = []
    cond_name = []
    search.each do |s|
      cond_desc<< "cvx_short_description LIKE '%#{s}%'"
      cond_name<< "cvx_code LIKE '%#{s}%'"
    end
    scope = ImmunizationCvx
    data = scope.where("((#{cond_name.join(' OR ')} )) OR (#{cond_desc.join(' AND ')} )").
        select("id AS id, CONCAT('(', cvx_code,') ', cvx_short_description ) AS value,  CONCAT('(', cvx_code,') ', cvx_short_description )  AS label").to_json

    render json: data
  end
end
