class CircleCI

  CircleCIRequest = require "./circleci-request"
  CircleCIResponse = require "./circleci-response"

  constructor: (config) ->
    if typeof config.auth isnt "string"
      throw new Error "API token must be provided"
    @request = new CircleCIRequest config
    @routes = require "./routes"

  getUser: ->
    @request.process @routes['getUser']

  getProjects:  ->
    @request.process @routes['getProjects']

  getRecentBuilds: (opts) ->
    @request.process @routes['getRecentBuilds'], opts

  getBuilds: (opts) ->
    @request.process @routes['getBuilds'], opts

  getBranchBuilds: (opts) ->
    @request.process @routes['getBranchBuilds'], opts

  getBuild: (opts) ->
    @request.process @routes['getBuild'], opts

  startBuild: (opts) ->
    @request.process @routes['startBuild'], opts

  cancelBuild: (opts) ->
    @request.process @routes['cancelBuild'], opts

  retryBuild: (opts) ->
    @request.process @routes['retryBuild'], opts

  getBuildArtifacts: (opts) ->
    @request.process @routes['getBuildArtifacts'], opts
  
  clearBuildCache: (opts) ->
    @request.process @routes['clearBuildCache'], opts

  getTestMetadata: (opts) ->
    @request.process @routes['getTestMetadata'], opts
    
  getEnvVars: (opts) ->
    @request.process @routes['getEnvVars'], opts

  getEnvVar: (opts) ->
    @request.process @routes['getEnvVar'], opts

  setEnvVar: (opts) ->
    @request.process @routes['setEnvVar'], opts

  deleteEnvVar: (opts) ->
    @request.process @routes['deleteEnvVar'], opts

module.exports = CircleCI
