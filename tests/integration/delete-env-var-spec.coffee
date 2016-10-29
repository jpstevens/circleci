CircleCI = require "../../src/circleci"

describe "deleteEnvVar", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      name: 'TEST_ENV_VAR'

  it "returns an object of the status of deleting an env var for a given project", (done) ->

    @circleci.deleteEnvVar(@config).then (res) ->
      expect(res).to.be.ok
      expect(res.tests).to.be.instanceof Object
      done()
