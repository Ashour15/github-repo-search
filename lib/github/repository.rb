require 'net/http'
require 'resolv-replace'

class Github::Repository 
  def self.search_repositories(query)
    uri = URI.parse("https://api.github.com/search/repositories?q=#{query}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true
    response = http.request(request)
    JSON.parse(response.body)
  end
end