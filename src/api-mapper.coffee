routes = require "../src/routes"
UrlGenerator = require "./url-generator"
qreq = require "qreq"

class ApiMapper

  constructor: (config) ->
    @ug = new UrlGenerator config

  getUrl: (fn, opts = {}) ->
    config = { query: {}, params: opts}
    route = routes[fn]
    if route.options
      for option in route.options
        config.query[option] = opts[option] if opts[option]
        delete opts[option]
    @ug.getUrl(route.endpoint, config)

  getMethod: (fn) ->
    routes[fn].method

  getRequestObject: (fn, opts = {}) ->
    method = @getMethod fn
    url = @getUrl fn, opts
    qreq[method.toLowerCase()](url)

module.exports = ApiMapper