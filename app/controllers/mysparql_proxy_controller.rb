require 'net/http'
class MysparqlProxyController < ApplicationController

  def create
    r = Net::HTTP.post_form(URI.parse(@site_config.mysparql_server + "v1/queries/"), { "query[query]" => params['sparql-query'], "query[source]" => params['data-source']})
    b = r.body.gsub(@site_config.mysparql_server + "v1", "/")
    render :text => b, :status => r.code
  end

  def show
    req = Net::HTTP::Get.new(URI.parse(@site_config.mysparql_server + "v1/queries/"+params[:id]))
    res = Net::HTTP.start do |http|
      http.request(req)
    end
    render :text => res.body, :status => res.code
  end

end
