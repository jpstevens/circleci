CircleCI = require "../../src/circleci"

describe "setEnvVar", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      body:
        name: 'TEST_ENV_VAR'
        value: 'TEST_ENV_VALUE'

  it "returns an object of a created env var for a given project", (done) ->

    @circleci.setEnvVar(@config).then (res) ->
      expect(res).to.be.ok
      expect(res.tests).to.be.instanceof Object
      done()
