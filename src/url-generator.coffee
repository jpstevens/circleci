qs = require "querystring"

class UrlGenerator
  
  constructor: (config = {}) ->
    @host = config.host or "https://circleci.com"
    @version = config.version or "v1"
    @apiToken = config.apiToken
  
  getBaseUrl: ->
    "#{@host}/api/#{@version}"

  getQueryString: (params = {}) ->
    paramString = qs.stringify(params)
    queryString = "?circleci_token=#{@apiToken}"
    queryString += "&#{paramString}" if paramString
    queryString

  injectParams: (path, params = {}, identifier = ":") ->
    fragments = path.split "/"
    for fragment, i in fragments
      for paramKey, paramValue of params
        regexp = new RegExp("^:#{paramKey}$")
        if(fragment.match(regexp))
          fragments[i] = fragment.replace(regexp, paramValue)
    fragments.join "/"

  getUrl: (path = "", config = {}) ->
    url = @getBaseUrl()
    url += ("/"+@injectParams path.replace(/^\//,""), config.params) if path
    url += @getQueryString(config.query)
    url
  
module.exports = UrlGenerator