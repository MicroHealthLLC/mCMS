module Snomed
  def url_tgt
    redis = Redis.new
    tgt = redis.get('tgt_token')
    unless tgt
     tgt = create_tgt
    end
    tgt
  end

  def create_tgt
    redis = Redis.new
    res = HTTParty.post("https://utslogin.nlm.nih.gov/cas/v1/api-key",
                        body: {
                            apikey: "2753a3a0-feaf-4083-839f-361384ec6990"
                        },
                        header: headers )
    f = Nokogiri::HTML(res.body).xpath('//form')
    tgt = f.first.attributes['action'].value
    redis.set('tgt_token', tgt)
    redis.expire 'tgt_token', 60 * 60 * 7 # 7 hours
    tgt
  end

  def get_st(tgt = url_tgt)
    res = HTTParty.post(tgt,
                        body: {service: get_service},
                        header: headers )
    res.body
  end

  def get_snomed_result(term, default_search, st_ticket = get_st)
    retries = 0
    data = []
    ticket = st_ticket
    begin
      res = HTTParty.get("https://uts-ws.nlm.nih.gov/rest/search/current",
                         query: {
                             ticket: ticket,
                             string: "#{term} #{default_search}"
                         } )
      json = JSON.parse res.body
      data = []
      if json['result']['results']
        data = json['result']['results'].map do |d|
          {id: d['name'], name: d['name'], label: d['name'] }
        end
      end
    rescue
      if retries == 0
        create_tgt
        retries += 1
        retry
      end

    end
    data
  end

  # def check_validity_ticket(ticket)
  #   res = HTTParty.get("http://utslogin.nlm.nih.gov/cas/serviceValidate",
  #                      query: {
  #                          ticket: ticket,
  #                          service: get_service
  #                      })
  # end

  def get_service
    "http://umlsks.nlm.nih.gov"
  end

  def headers
    {'Content-Type'  => 'application/x-www-form-urlencoded'}
  end
end