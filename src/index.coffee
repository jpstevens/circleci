HTTPStatus = require "http-status"
request = require "request"
Q = require "q"

class Qreq

  standardRequest = (config) ->
    # init defer object
    deferred = Q.defer()
    # make request
    request config, (err, res) ->
      if err
        deferred.reject err
      else
        deferred.resolve res
    # return promise
    deferred.promise

  parseConfigParams = (method, urlOrConfig, data) ->
    switch typeof urlOrConfig
      when "object"
        config = urlOrConfig
        config.method = method.toUpperCase()
      when "string"
        config = { method: method.toUpperCase(), url: urlOrConfig }
      else
        throw new Error "Method '#{method.toLowerCase()}' requires either a 'url' value or 'config' object."
    config.json = data if data
    config

  @get: (urlOrConfig) ->
    standardRequest parseConfigParams("get", urlOrConfig)

  @post: (urlOrConfig, data) ->
    standardRequest parseConfigParams("post", urlOrConfig, data)

  @delete: (urlOrConfig) ->
    standardRequest parseConfigParams("delete", urlOrConfig)

  @put: (urlOrConfig, data) ->
    standardRequest parseConfigParams("put", urlOrConfig, data)

module.exports = Qreq