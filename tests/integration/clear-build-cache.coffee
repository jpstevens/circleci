CircleCI = require "../../src/circleci"

describe "clearBuildCache", ->

  before ->
    @circleci = new CircleCI { auth: process.env.CIRCLE_TOKEN }
    @config =
      username: process.env.CIRCLE_USER
      project: process.env.CIRCLE_PROJECT

  it "clears the build cache", (done) ->

    @circleci.clearBuildCache(@config).then (res) ->
      expect(res).to.be.ok
      done()
