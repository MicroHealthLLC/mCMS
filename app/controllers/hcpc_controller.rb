class HcpcController < ProtectForgeryApplication
  def index
    q = params[:term]
    search = q.to_s.split(' ')
    cond_desc = []
    cond_name = []
    search.each do |s|
      cond_desc<< "long_description LIKE '%#{s}%'"
      cond_name<< "hcpc LIKE '%#{s}%'"
    end
    scope = Hcpc
    data = scope.where("((#{cond_name.join(' OR ')} )) OR (#{cond_desc.join(' AND ')} )").
        select("id AS id, CONCAT('(', hcpc,') ', short_description ) AS value,  CONCAT('(', hcpc,') ', short_description )  AS label").to_json

    render json: data
  end
end
