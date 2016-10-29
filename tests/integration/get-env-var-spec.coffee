CircleCI = require "../../src/circleci"

describe "getEnvVar", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT
      name: process.env.CIRCLE_USER

  it "returns an object of a given env var for a given project", (done) ->

    @circleci.getEnvVar(@config).then (res) ->
      expect(res).to.be.ok
      expect(res.tests).to.be.instanceof Object
      done()
