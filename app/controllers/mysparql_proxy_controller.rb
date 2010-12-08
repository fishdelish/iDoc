require 'net/http'
class MysparqlProxyController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    r = Net::HTTP.post_form(URI.parse(@site_config.mysparql_server + "v1/queries/"), { "query[query]" => params['sparql-query'], "query[source]" => params['data-source'], "query[xslt_path]" => params['xslt-url']})
    render :text => r.body, :status => r.code
  end

  def show
    if params.has_key? :tutorial
      uri = URI.parse(@site_config.mysparql_server + "v1/queries/#{params[:id]}/data")
    else
      
      uri = URI.parse(@site_config.mysparql_server + "v1/queries/#{params[:id]}")
    end
    req = Net::HTTP::Get.new(uri.path)
    res = Net::HTTP.start(uri.host, uri.port) do |http|
      http.request(req)
    end
    render :text => res.body, :status => res.code
  end

  def run
    r = Net::HTTP.post_form(URI.parse(@site_config.mysparql_server + "v1/queries/"+params[:query_id]+"/run"), {"query" => params[:query]})
    render :text => r.body, :status => r.code
  end

  def preview
    r = Net::HTTP.post_form(URI.parse(@site_config.mysparql_server + "v1/queries/preview/"), params.merge({ "query[query]" => params['sparql-query'], "query[source]" => params['data-source']}))
    render :text => r.body, :status => r.code
  end

  def param_query
    if params.has_key? :tutorial
      uri = URI.parse(@site_config.mysparql_server + "v1/queries/" + params[:query_id] + "/param_data")
    else
      uri = URI.parse(@site_config.mysparql_server + "v1/queries/" + params[:query_id] + "/param_query")
    end
    r = Net::HTTP.post_form(uri, params)
    render :text => r.body, :status => r.code
  end
end
