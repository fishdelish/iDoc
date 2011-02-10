require 'net/http'
class MysparqlProxyController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def proxy
    uri = URI.parse(@site_config.mysparql_server + "v1/" + params[:path].join("/"))
    if request.get?
      path = uri.path
      path += "?#{request.query_string}" unless request.query_string.blank?
      req = Net::HTTP::Get.new(path)
    else 
      if request.post? 
        req = Net::HTTP::Post.new(uri.path)
      elsif request.put?
        req = Net::HTTP::Put.new(uri.path)
      end
      req.body = request.body.read
    end
    res = Net::HTTP.start(uri.host, uri.port) do |h| 
      h.read_timeout = 3600
      h.request(req)
    end
    send_data res.body, :status => res.code, :type => res.content_type      
  end
end
