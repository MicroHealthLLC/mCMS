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

  def get_snomed_result(term, default_search, options = {} )
    json = get_json(term, default_search, options)
    data = []

    if json['result']['results'].first['name'] == 'NO RESULTS'
      json = get_json(term, default_search, options.reverse_merge({searchType: 'approximate', pageSize: 200 }))
      if json['result']['results']
        results = json['result']['results'].select{|v| v['name'].include?(term) }
        data = results.map do |d|
          {id: d['name'], name: d['name'], label: d['name'] }
        end
        if data.empty?
          data = [{id: 'NO RESULTS', name: 'NO RESULTS', label: 'NO RESULTS' }]
        end
      end
    # data = get_snomed_from_ihtsdotools(term, default_search)
    elsif json['result']['results']
      data = json['result']['results'].map do |d|
        {id: d['name'], name: d['name'], label: d['name'] }
      end
    end

    data
  rescue
    data
  end

  # def get_snomed_from_ihtsdotools(term, default_search)
  #   url = 'http://browser.ihtsdotools.org/api/snomed/en-edition/v20170131/descriptions'
  #   res = HTTParty.get(url,
  #                      query: {
  #                          query: "#{term} #{default_search}",
  #                          limit: 50,
  #                          searchMode: 'partialMatching'
  #                      })
  #   json = JSON.parse res.body
  #   json['matches'].map do |d|
  #     {id: d['fsn'], name: d['fsn'], label: d['fsn'] }
  #   end
  # end

  def get_json(term, default_search, options = {} )
    st_ticket = get_st
    retries = 0
    json = {}
    ticket = st_ticket
    begin
      res = HTTParty.get("https://uts-ws.nlm.nih.gov/rest/search/current",
                         query: {
                             ticket: ticket,
                             string: "#{term} #{default_search}"
                         }.merge(options) )
      json = JSON.parse res.body
    rescue
      if retries == 0
        create_tgt
        retries += 1
        retry
      end
    end
    json
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