CircleCI = require "../../src/circleci"

describe "getEnvVars", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT

  it "returns an array of the env vars for a given project", (done) ->

    @circleci.getEnvVars(@config).then (res) ->
      expect(res).to.be.ok
      expect(res.tests).to.be.instanceof Array
      done()
