q = require "q"
qs = require "querystring"
urlHelper = require "url"
CircleCIResponse = require "./circleci-response"

class CircleCIRequest

  constructor: (config = {}) ->
    @url = "https://circleci.com/api/v1/"
    @auth = config.auth
    @request = require "request"

  buildUrl: (path = "", query = {}, urlParams = {}) ->
    path = @injectParams path, urlParams
    query['circle-token'] = @auth
    url = @url + path.replace(/^\//, "")
    url += "?" + qs.stringify query
    url = url.replace "/?","?"
    url

  injectParams: (path, params = {}) ->
    path = "/#{path}"
    fragments = path.match(/\/:[A-z0-9_-]+/g) or []
    for fragment in fragments
      key = fragment.replace("/:", "")
      if params[key] is undefined
        throw new Error "Method requires '#{key}' option."
      path = path.replace fragment, "/#{params[key]}"
    path.replace(/^\//, "")

  buildRequestConfig: (resource, data) ->
    config = {}
    # config method
    config.method = resource.method
    # config url
    query = @buildQueryObject (resource.options or []), (data or {})
    config.url = @buildUrl resource.path, query, data
    # config data
    config.json = true
    config

  buildQueryObject: (availableOptions, data) ->
    query = {}
    for option in availableOptions
      (query[option] = data[option]) if data[option] isnt undefined
    query

  process: (resource, opts) =>
    config = @buildRequestConfig resource, opts
    # init request
    deferred = q.defer()
    @request config, (err, res) =>
      return deferred.reject err if err
      @handleResponse(deferred)(res)
    deferred.promise

  handleResponse: (deferred) ->
    (res) ->
      response = new CircleCIResponse res
      return deferred.resolve response.body if response.success()
      return deferred.reject response.clientError() if response.clientError()
      return deferred.reject response.serverError() if response.serverError()
      null

module.exports = CircleCIRequest
