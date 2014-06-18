qreq = require "qreq"

class CircleCI

  @init: (config) -> new CircleCI config

  constructor: (config) ->
    # api token
    if config.apiToken then @apiToken = config.apiToken
    else throw new Error "API Token required"
    # version
    @version = config.version or "v1"
    # host (for testing)
    @host = config.host or "https://circleci.com/api"

  getUser: (callback) ->
    qreq
    .get("#{@host}/me?circleci_token=#{@apiToken}")
    .then (res) -> callback null, res.body
    .fail (err) -> callback err

  getProjects: (callback) ->
    qreq
    .get("#{@host}/projects?circleci_token=#{@apiToken}")
    .then (res) -> callback null, res.body
    .fail (err) -> callback err

module.exports = CircleCI