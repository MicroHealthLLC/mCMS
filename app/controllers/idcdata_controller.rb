class IdcdataController < ApplicationController
  before_action  :authenticate_user!
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

  def medication
    q = params[:term]
    url = "https://rxnav.nlm.nih.gov/REST/drugs.json?name=#{q}"
    response = Faraday.get url
    j = JSON.parse response.body
    data = []
    Array.wrap(j["drugGroup"]['conceptGroup']).each do |drug|
      conceptProperties = drug['conceptProperties']
      Array.wrap(conceptProperties).each do |d|

        hash = {rxcui: d['rxcui'], tty: d['tty'], name: d['name'], label: d['synonym'] }
        data<< hash
      end
    end
    render json: data
  end
end
