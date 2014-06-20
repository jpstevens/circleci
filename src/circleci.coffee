qreq = require "qreq"
ApiMapper = require "./api-mapper"
q = require "q"

class CircleCI

  @init: (config) -> new CircleCI config

  constructor: (config) ->
    # api token
    throw new Error "API Token required" unless config.apiToken
    # api mapper
    @mapper = new ApiMapper config

  makeRequest: (fn, opts = {}, callback = null) ->
    deferred = q.defer()
    if typeof opts is 'function'
      callback = opts 
      opts = {}
    @mapper
    .getRequestObject(fn, opts)
    .then (res) ->
      deferred.resolve res.body
      callback null, res.body if callback
    .fail (err) ->
      deferred.reject err
      callback err if callback
    deferred.promise

  getUser: (callback) -> @makeRequest "getUser", callback

  getRecentProjects: (config, callback) -> @makeRequest "getRecentProjects", config, callback

  getProject: (config, callback) -> @makeRequest "getProject", config, callback

  getRecentBuilds: (config, callback) -> @makeRequest "getRecentBuilds", config, callback

  getBuild: (config, callback) -> @makeRequest "getBuild", config, callback

  startBuild: (config, callback) -> @makeRequest "startBuild", config, callback

  cancelBuild: (config, callback) -> @makeRequest "cancelBuild", config, callback

  retryBuild: (config, callback) -> @makeRequest "retryBuild", config, callback

  getBuildArtifacts: (config, callback) -> @makeRequest "getBuildArtifacts", config, callback

  clearBuildCache: (config, callback) -> @makeRequest "clearBuildCache", config, callback


module.exports = CircleCI