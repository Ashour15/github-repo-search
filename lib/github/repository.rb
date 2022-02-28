require 'net/http'
require 'resolv-replace'
class Github::Repository 
  BASE_URL = 'https://api.github.com'
  CACHE_TIME = 3600 # 1 hour

  def self.search_repositories(options)
    search_url = "/search/repositories?q=#{options[:query]}&page=#{options[:page]}&per_page=#{options[:per_page]}"
    cache_key = "#{options[:query]}#{options[:page]}"
    APICache.get(cache_key, :cache => CACHE_TIME) do
      uri = URI.parse(BASE_URL + search_url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      http.use_ssl = true
      response = http.request(request)
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)['items']
      else
        nil
      end
    end
  end
end