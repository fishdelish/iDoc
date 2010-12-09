require 'net/http'
class MysparqlProxyController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def proxy
    uri = URI.parse(@site_config.mysparql_server + "v1/" + params[:path].join("/"))
    if request.get?
      req = Net::HTTP::Get.new(uri.path)
      req.query_string = request.query_string
    else 
      if request.post? 
        req = Net::HTTP::Post.new(uri.path)
      elsif request.put?
        req = Net::HTTP::Put.new(uri.path)
      end
      req.body = request.body.read
    end
    res = Net::HTTP.start(uri.host, uri.port) {|h| h.request(req)}
    send_data res.body, :status => res.code, :type => res.content_type      
  end
end
